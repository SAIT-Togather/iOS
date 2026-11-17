//
//  KeyboardManager.swift
//  SAIT
//
//  Created by 이머영 on 11/8/26.
//

import Foundation
import UIKit

final class KeyboardManager {
    
    
    // MARK: - Properties
    
    private weak var scrollView: UIScrollView?
    private weak var activeTextField: UITextField?
    
    private var keyboardObservers: [NSObjectProtocol] = []
    
    
    // MARK: - Initializer
    
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
    
    
    // MARK: - Public Method
    
    func startObserving() {
        guard keyboardObservers.isEmpty else {
            return
        }
        
        let keyboardObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.keyboardWillChangeFrame(notification)
        }
        
        keyboardObservers.append(keyboardObserver)
    }
    
    func stopObserving() {
        for observer in keyboardObservers {
            NotificationCenter.default.removeObserver(observer)
        }
        
        keyboardObservers.removeAll()
    }
    
    func setActiveTextField(_ textField: UITextField) {
        activeTextField = textField
    }
    
    private func keyboardWillChangeFrame(_ notification: Notification) {
        guard let scrollView = scrollView,
              let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[
                UIResponder.keyboardFrameEndUserInfoKey
              ] as? NSValue else {
            return
        }
        
        // 1. 키보드의 최종 프레임
        let keyboardFrame = keyboardFrameValue.cgRectValue
        
        // 2. 키보드 프레임을 ScrollView 좌표계로 변환
        let keyboardFrameInScrollView = scrollView.convert(
            keyboardFrame,
            from: nil
        )
        
        // 3. ScrollView와 키보드가 겹치는 높이 계산
        let overlapHeight = scrollView.bounds.intersection(
            keyboardFrameInScrollView
        ).height
        
        // 4. ScrollView 하단 여백 설정
        var contentInset = scrollView.contentInset
        contentInset.bottom = overlapHeight
        
        var indicatorInset = scrollView.verticalScrollIndicatorInsets
        indicatorInset.bottom = overlapHeight
        
        // 5. 키보드 애니메이션 정보
        let duration = (
            userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]
            as? NSNumber
        )?.doubleValue ?? 0.25
        
        let curve = (
            userInfo[UIResponder.keyboardAnimationCurveUserInfoKey]
            as? NSNumber
        )?.uintValue ?? 7
        
        let options = UIView.AnimationOptions(
            rawValue: UInt(curve << 16)
        )
        
        // 6. 키보드 애니메이션과 함께 여백 변경
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options
        ) {
            scrollView.contentInset = contentInset
            scrollView.verticalScrollIndicatorInsets = indicatorInset
            
            self.scrollToActiveTextField(
                keyboardFrame: keyboardFrame,
                animated: false
            )
        }
    }
    
    private func scrollToActiveTextField(
        keyboardFrame: CGRect,
        animated: Bool
    ) {
        guard let scrollView = scrollView,
              let activeTextField = activeTextField else {
            return
        }
        
        // 1. 현재 입력창의 위치를 ScrollView 좌표계로 변환
        let textFieldFrame = activeTextField.convert(
            activeTextField.bounds,
            to: scrollView
        )
        
        // 2. 키보드 위치를 ScrollView 좌표계로 변환
        let keyboardFrameInScrollView = scrollView.convert(
            keyboardFrame,
            from: nil
        )
        
        // 3. 입력창 아래에 확보할 여유 공간
        let padding: CGFloat = 16
        
        // 4. 입력창이 키보드에 가려지는지 확인
        let visibleBottom = min(
            scrollView.bounds.maxY,
            keyboardFrameInScrollView.minY
        )
        
        guard textFieldFrame.maxY + padding > visibleBottom else {
            return
        }
        
        // 5. 입력창이 보이도록 스크롤
        let targetRect = textFieldFrame.insetBy(
            dx: 0,
            dy: -padding
        )
        
        scrollView.scrollRectToVisible(
            targetRect,
            animated: animated
        )
    }
    
    func clearActiveTextField() {
        activeTextField = nil
    }
    
    
    // MARK: - Deinitializer
    
    deinit {
        stopObserving()
    }
}
