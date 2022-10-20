//
//  WireframeInterface.swift
//  ArrvisCore
//
//  Created by dat.nguyenquoc on 2018/02/08.
// 
//

import UIKit
import AVFoundation
import MobileCoreServices
import Photos
import RxSwift

private var imagePickerDelegateKey = 0
private var disposeBagKey = 1

public protocol WireframeInterface: class, ErrorHandleable, MediaPickerTypeSelectActionSheetHandler {

    /// Navigator
    var navigator: BaseNavigator {get}

    /// モジュール生成
    ///
    /// - Parameter payload: ペイロード
    /// - Returns: UIViewController
    static func generateModule(_ payload: Any?) -> UIViewController
}

/// General
extension WireframeInterface {

    /// アプリ設定表示
    public func showAppSettings() {
        UIApplication.shared.open(URL(string: "app-settings:root=General&path=" + Bundle.main.bundleIdentifier!)!,
                                  options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]),
                                  completionHandler: nil)
    }

    public func showPhotoApp() {
        UIApplication.shared.open(URL(string: "photos-redirect://")!,
                                  options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]),
                                  completionHandler: nil)
    }

    public func openSafari(_ stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    public func callEmergency() {
        DeviceService.shared.isUsing = true
        func cantCallEmergencyNumber() {
            DeviceService.shared.isUsing = false
            let titleAlert = "\(emergencyNumber)\(R.string.localizable.alertTitleCantCallPhoneNumber())"
            showOkAlert(title: titleAlert,
                        message: R.string.localizable.alertMessageCantCallPhoneNumber(),
                        ok: R.string.localizable.alertButtonOk())
        }

        let shortEmergencyNumber = emergencyNumber.replaceCharacter(string: "-")
        let linkEmergency = URL(string: "tel://\(shortEmergencyNumber)")!
        guard UIApplication.shared.canOpenURL(linkEmergency), DeviceService.shared.canMakePhoneCall() else {
            cantCallEmergencyNumber()
            return
        }

        //Check device turn on Airplane Mode
        DeviceService.shared.checkAirplaneMode { (isAirplane) in
            if isAirplane {
                DispatchQueue.runOnMainThread {
                    cantCallEmergencyNumber()
                }
            } else {
                let titleCallToNumber = "\(emergencyNumber)\(R.string.localizable.alertMessageCallToNumber())"
                DispatchQueue.runOnMainThread {
                    DeviceService.shared.isUsing = false
                    self.showConfirmAlert(
                        title: "",
                        message: titleCallToNumber,
                        messageFont: UIFont.boldSystemFont(ofSize: 17),
                        ok: R.string.localizable.alertButtonCallPhoneNumber(),
                        onOk: {
                            UIApplication.shared.open(linkEmergency, options: [:], completionHandler: nil)
                        },
                        cancel: R.string.localizable.alertButtonCancel())
                }
            }
        }
    }
}

/// Screen
extension WireframeInterface {

    /// dismiss Screen
    public func dismissScreen(result: Any? = nil) {
        navigator.dismissScreen(result: result)
    }

    /// pop Screen
    public func popScreen(result: Any? = nil, _ animate: Bool = true) {
        navigator.popScreen(result: result, animate: animate)
    }
}

/// Activity / Alert / ActionSheet
extension WireframeInterface {

    /// Activity表示
    public func showActivityScreen(_ activityItems: [Any],
                                   _ applicationActivities: [UIActivity]? = nil,
                                   _ excludedActivityTypes: [UIActivity.ActivityType]? = nil) {
        navigator.navigate(screen: SystemScreens.activity,
                           payload: ActivityInfo(activityItems: activityItems,
                                                 applicationActivities: applicationActivities,
                                                 excludedActivityTypes: excludedActivityTypes)
        )
    }

    /// OKアラート表示
    public func showOkAlert(title: String?, message: String?, ok: String?) {
        showOkAlert(title: title, message: message, ok: ok, onOk: {})
    }

    /// OKアラート表示
    public func showOkAlert(title: String?, message: String?, ok: String?, onOk: @escaping () -> Void) {
        if MaintenanceUpdator.isMaintenanceMode { return }
        showAlert(title: title, message: message, actions: [ (ok ?? "OK"): (.default, { onOk() }) ] )
    }

    /// 確認アラート表示
    public func showConfirmAlert(title: String? = "",
                                 message: String?,
                                 messageFont: UIFont? = nil,
                                 ok: String,
                                 onOk: @escaping () -> Void,
                                 cancel: String,
                                 okStyle: UIAlertAction.Style = .default,
                                 onCancel: (() -> Void)? = nil) {
        showAlert(
            title: title,
            message: message,
            messageFont: messageFont,
            actions: [
                ok: (okStyle, { onOk() })
            ],
            cancel: cancel,
            onCancel: onCancel)
    }

    /// Alert Confirm password
    public func showConfirmAlertPassword(title: String? = "",
                                         message: String?,
                                         ok: String,
                                         onOk: @escaping (_ password: String) -> Void,
                                         cancel: String,
                                         onCancel: @escaping () -> Void) {
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = R.string.localizable.alertMessageConfirmPasswordPlacehoder()
        }
        alertController.addAction(UIAlertAction(title: cancel, style: .default, handler: { (_) in
            onCancel()
        }))
        alertController.addAction(UIAlertAction(title: ok, style: .default, handler: { (_) in
            guard let password = alertController.textFields?[0].text else {
                return
            }
            onOk(password)
        }))
        navigator.navigate(screen: SystemScreens.alertTextField, payload: alertController)
    }

    /// アラート表示
    public func showAlert(title: String?,
                          message: String?,
                          messageFont: UIFont? = nil,
                          actions: [String: (UIAlertAction.Style, () -> Void)],
                          cancel: String? = nil,
                          onCancel: (() -> Void)? = nil) {
        if MaintenanceUpdator.isMaintenanceMode { return }
        let alertInfo = AlertInfo(
            title: title,
            message: message,
            messageFont: messageFont,
            actions: actions,
            cancel: cancel,
            onCancel: onCancel
        )
        navigator.navigate(screen: SystemScreens.alert, payload: alertInfo)
    }

    /// 切断時、アラート表示
    public func showAlertLoadDataFailed() {
        if MaintenanceUpdator.isMaintenanceMode { return }
        showOkAlert(title: R.string.localizable.alertTitleError(),
                    message: R.string.localizable.alertMessageDisconnectToNetwork(),
                    ok: R.string.localizable.alertButtonOk(),
                    onOk: {})
    }

    /// Email or password is incorrect on the Setting screen
    func showAlertIncorrectEmailPassword(completion: @escaping () -> Void) {
        showOkAlert(title: R.string.localizable.alertTitleError(),
                              message: R.string.localizable.alertMessageIncorrect_Email_Password_Japan(),
                              ok: R.string.localizable.alertButtonOk(),
                              onOk: {
                                completion()
                              })
    }

    /// 切断時、アラート表示とデータ更新
    public func showAlertLoadDataFailed(completion: @escaping () -> Void) {
        showConfirmAlert(
            title: R.string.localizable.alertTitleTurnOffNetWork(),
            message: R.string.localizable.alertMessageTurnOffNetworkWhenCallAPI(),
            ok: R.string.localizable.alertButtonOk(),
            onOk: {
                completion()
            },
            cancel: R.string.localizable.alertButtonCancel())
    }

    public func showAlertOldDataKeychain() {
        showOkAlert(title: "",
                    message: R.string.localizable.alertMessageDataLoginKeychainInvalid(),
                    ok: R.string.localizable.alertButtonOk())
    }

    /// アクションシート表示
    public func showActionSheet(title: String?,
                                message: String?,
                                actions: [String: (UIAlertAction.Style, () -> Void)],
                                cancel: String? = nil,
                                onCancel: (() -> Void)? = nil) {
        let alertInfo = AlertInfo(
            title: title,
            message: message,
            messageFont: nil,
            actions: actions,
            cancel: cancel,
            onCancel: onCancel
        )
        navigator.navigate(screen: SystemScreens.actionSheet, payload: alertInfo)
    }
    
    func showAccessControlAlert(_ message: String,
                                completion: @escaping () -> Void) {
        showConfirmAlert(
            message: message,
            ok: R.string.localizable.alertButtonLitePlan(),
            onOk: completion,
            cancel: R.string.localizable.alertButtonOk())
    }
    
    func showChatMessagesScreen(_ payload: (CurrentUserQuery.Data.CurrentUser, ChatRoom), _ animate: Bool) {
        navigator.navigate(screen: AppScreens.chatMessages, payload: payload, animate: animate)
    }
}

/// ImagePicker
extension WireframeInterface {

    private var imagePickerDelegate: ImagePickerDelegate? {
        get {
            return objc_getAssociatedObject(self, &imagePickerDelegateKey) as? ImagePickerDelegate ?? nil
        }
        set {
            objc_setAssociatedObject(self, &imagePickerDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    fileprivate var disposeBag: DisposeBag {
        get {
            guard let object = objc_getAssociatedObject(self, &disposeBagKey) as? DisposeBag else {
                self.disposeBag = DisposeBag()
                return self.disposeBag
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &disposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// メディア選択アクションシート表示
    public func showMediaPickerSelectActionSheetScreen(
        _ cameraRollEventHandler: CameraRollEventHandler,
        _ mediaTypes: [CFString] = [kUTTypeImage, kUTTypeMovie]) {
        var actions = [
            photoLibraryButtonTitle(): (UIAlertAction.Style.default, { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.showLibraryScreen(cameraRollEventHandler, mediaTypes)
            })
        ]
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actions[cameraButtonTitle()] = (.default, { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.showCameraScreen(cameraRollEventHandler, mediaTypes)
            })
        }
        showActionSheet(title: sheetTitle(),
                        message: sheetMessage(),
                        actions: actions,
                        cancel: cancelButtonTitle()) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.onCancel()
        }
    }

    public func showImagePickerSelectActionSheetScreen(
        _ cameraRollEventHandler: CameraRollEventHandler,
        _ mediaTypes: [CFString] = [kUTTypeImage, kUTTypeMovie]) {
        let actions = [
            imageLibraryButtonTitle(): (UIAlertAction.Style.default, { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.showLibraryScreen(cameraRollEventHandler, mediaTypes)
            })
        ]
        showActionSheet(title: sheetTitle(),
                        message: sheetMessage(),
                        actions: actions,
                        cancel: cancelButtonTitle()) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.onCancel()
        }
    }

    /// ライブラリスクリーン表示
    public func showLibraryScreen(_ handler: CameraRollEventHandler,
                                  _ mediaTypes: [CFString] = [kUTTypeImage, kUTTypeMovie]) {
        requestAccessToPhotoLibrary().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] status in
            if status == .authorized {
                guard let weakSelf = self else { return }
                weakSelf.imagePickerDelegate = ImagePickerDelegate(handler)
                weakSelf.navigator.navigate(
                    screen: SystemScreens.imagePicker,
                    payload: (
                        weakSelf.imagePickerDelegate,
                        UIImagePickerController.SourceType.photoLibrary,
                        mediaTypes
                    )
                )
            } else {
                handler.onFailAccessPhotoLibrary()
            }
        }).disposed(by: disposeBag)
    }

    /// カメラスクリーン表示
    public func showCameraScreen(_ handler: CameraRollEventHandler,
                                 _ mediaTypes: [CFString] = [kUTTypeImage, kUTTypeMovie]) {
        requestAccessToTakeMovie().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] ret in
            if ret {
                guard let weakSelf = self else { return }
                weakSelf.imagePickerDelegate = ImagePickerDelegate(handler)
                weakSelf.navigator.navigate(
                    screen: SystemScreens.imagePicker,
                    payload: (
                        weakSelf.imagePickerDelegate,
                        UIImagePickerController.SourceType.camera,
                        mediaTypes
                    )
                )
            } else {
                handler.onFailAccessCamera()
            }
        }).disposed(by: disposeBag)
    }

    /// フォトライブラリへのアクセスリクエスト
    public func requestAccessToPhotoLibrary() -> Observable<PHAuthorizationStatus> {
        return Observable.create({ observer in
            PHPhotoLibrary.requestAuthorization { status in
                observer.onNext(status)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }

    /// 動画撮影アクセスリクエスト
    public func requestAccessToTakeMovie() -> Observable<Bool> {
        return Observable.create({ observer in
            AVCaptureDevice.requestAccess(for: .video) { authorized in
                observer.onNext(authorized)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
}

private class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var cameraRollEventHandler: CameraRollEventHandler

    init(_ cameraRollEventHandler: CameraRollEventHandler) {
        self.cameraRollEventHandler = cameraRollEventHandler
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) { [weak self] in
            guard let weakSelf = self else { return }
            let infoConvert = convertFromUIImagePickerControllerInfoKeyDictionary(info)
            if let image = infoConvert[convertFromUIImagePickerControllerInfoKey(.originalImage)] as? UIImage {
                if let handlerCreate = weakSelf.cameraRollEventHandler as? CurriculumCreationViewController {
                    weakSelf.onImageSelectedWithTypeAccess(image, handlerCreate, info)
                } else if let handlerEdit = weakSelf.cameraRollEventHandler as? CurriculumEditingViewController {
                    weakSelf.onImageSelectedWithTypeAccess(image, handlerEdit, info)
                } else {
                    weakSelf.cameraRollEventHandler.onImageSelected(image)
                    if let imageUrl = infoConvert[convertFromUIImagePickerControllerInfoKey(.imageURL)] as? URL {
                        weakSelf.cameraRollEventHandler.onImageSelected(imageUrl)
                    }
                }
            } else if let url = infoConvert[convertFromUIImagePickerControllerInfoKey(.mediaURL)] as? URL {
                weakSelf.cameraRollEventHandler.onMediaSelected(url)
            } else if let asset = weakSelf.assetFromInfoKey(infoConvert) {
                asset.getURL(completionHandler: { [weak self] responseUrl in
                    if let url = responseUrl {
                        guard let nonNullSelf = self else { return }
                        nonNullSelf.cameraRollEventHandler.onMediaSelected(url)
                    }
                })

            }
        }
    }

    private func onImageSelectedWithTypeAccess(_ image: UIImage,
                                               _ handler: CameraRollEventHandler,
                                               _ info: [UIImagePickerController.InfoKey: Any]) {
        if let assetPath = info[.imageURL] as? URL {
            let urlString = assetPath.absoluteString.lowercased()
            if (urlString.hasSuffix("jpg")) {
                handler.onImageSelected(image, true)
            } else if (urlString.hasSuffix("jpeg")) {
                handler.onImageSelected(image, true)
            } else if (urlString.hasSuffix("png")) {
                handler.onImageSelected(image, true)
            } else if (urlString.hasSuffix("heic")) {
                handler.onImageSelected(image, true)
            } else {
                handler.onImageSelected(image, false)
            }
        } else {
            handler.onImageSelected(image, false)
        }
    }

    private func assetFromInfoKey(_ info: [String: Any]) -> PHAsset? {
        if #available(iOS 11.0, *) {
            return info[UIImagePickerController.InfoKey.phAsset.rawValue] as? PHAsset
        } else {
            guard let url = info[UIImagePickerController.InfoKey.referenceURL.rawValue] as? URL else { return nil }
            return PHAsset.fetchAssets(withALAssetURLs: [url], options: nil).firstObject
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.cameraRollEventHandler.onCanceled()
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(
    _ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues:
        input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)}
    )
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

// Show alert disconnect to Network
func showAlertHaveNotNetwork(completion: @escaping () -> Void) {
    guard let controller = AppDelegate.shared.appRootViewController.currentViewController(), !(controller is UIAlertController) else {
        ActivityIndicatorManager.shared.hide()
        return
    }
    let alert = UIAlertController(title: R.string.localizable.alertTitleTurnOffNetWork(),
                                  message: R.string.localizable.alertMessageTurnOffNetworkWhenCallAPI(),
                                  preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: R.string.localizable.alertButtonOk(), style: .default) { ( _ ) in
        completion()
    }
    let cancelAction = UIAlertAction(title: R.string.localizable.alertButtonCancel(), style: .cancel) { ( _ ) in
        ActivityIndicatorManager.shared.hide()
    }
    alert.addAction(cancelAction)
    alert.addAction(confirmAction)
    controller.present(alert, animated: true, completion: nil)
}

// Show alert error network from apollo
func showAlertHandleNetworkError(_ message: String) {
    guard let controller = AppDelegate.shared.appRootViewController.currentViewController(), !(controller is UIAlertController) else {
        ActivityIndicatorManager.shared.hide()
        return
    }
    let alert = UIAlertController(title: R.string.localizable.alertTitleError(),
                                  message: message,
                                  preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: R.string.localizable.alertButtonOk(), style: .default) { ( _ ) in
        ActivityIndicatorManager.shared.hide()
    }
    alert.addAction(confirmAction)
    controller.present(alert, animated: true, completion: nil)
}

// Show alert locked out of biometric
func showAlertLockedOutBiometric() {
    guard let controller = AppDelegate.shared.appRootViewController.currentViewController(), !(controller is UIAlertController) else { return }
    let alert = UIAlertController(title: "", message: R.string.localizable.alertMessageLockedOutBiometric(), preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: R.string.localizable.alertButtonOk(), style: .default, handler: nil)
    alert.addAction(confirmAction)
    controller.present(alert, animated: true, completion: nil)
}

// Show alert config on the firebase remote config
func showAlertMessageRemoteConfig(_ message: String,
                                  _ titleButton: String = R.string.localizable.alertButtonOk(),
                                  _ completion: @escaping () -> Void) {
    guard let controller = AppDelegate.shared.appRootViewController.currentViewController(), !(controller is UIAlertController) else {
        return
    }
    let alert = UIAlertController(title: "",
                                  message: message,
                                  preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: titleButton, style: .default) { ( _ ) in
        completion()
    }
    alert.addAction(confirmAction)
    UIApplication.shared.delegate!.window!?.rootViewController!.present(
        alert,
        animated: true,
        completion: nil
    )
}
