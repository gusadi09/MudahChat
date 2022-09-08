//
//  MultilineTextField.swift
//  MudahChat (iOS)
//
//  Created by Gus Adi on 08/09/22.
//

import SwiftUI
import UIKit

private struct UITextViewWrapper: UIViewRepresentable {
	typealias UIViewType = UITextView

	@Binding var text: String
	@Binding var calculatedHeight: CGFloat
	var onDone: (() -> Void)?
	var onEditing: (() -> Void)?
	var onEndEditing: (() -> Void)?

	func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
		let textField = UITextView()
		textField.delegate = context.coordinator

		textField.isEditable = true
		textField.isSelectable = true
		textField.textColor = .black
		textField.font = UIFont.systemFont(ofSize: 12)
		textField.isUserInteractionEnabled = true
		textField.isScrollEnabled = true
		textField.backgroundColor = UIColor.clear
		if nil != onDone {
			textField.returnKeyType = .done
		}

		textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
		return textField
	}

	func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
		if uiView.text != self.text {
			uiView.text = self.text
		}

		UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
	}

	fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
		let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))

		if result.wrappedValue != newSize.height {
			DispatchQueue.main.async {
				result.wrappedValue = newSize.height
			}
		}
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(
			text: $text,
			height: $calculatedHeight,
			onDone: onDone,
			onEditing: onEditing,
			onEndEditing: onEndEditing
		)
	}

	final class Coordinator: NSObject, UITextViewDelegate {
		var text: Binding<String>
		var calculatedHeight: Binding<CGFloat>
		var onDone: (() -> Void)?
		var onEditing: (() -> Void)?
		var onEndEditing: (() -> Void)?

		init(
			text: Binding<String>,
			height: Binding<CGFloat>,
			onDone: (() -> Void)? = nil,
			onEditing: (() -> Void)? = nil,
			onEndEditing: (() -> Void)? = nil
		) {
			self.text = text
			self.calculatedHeight = height
			self.onDone = onDone
			self.onEditing = onEditing
			self.onEndEditing = onEndEditing
		}

		func textViewDidChange(_ uiView: UITextView) {
			text.wrappedValue = uiView.text

			guard let onEditing = onEditing else {
				return
			}

			onEditing()

			UITextViewWrapper.recalculateHeight(view: uiView, result: self.calculatedHeight)
		}

		func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
			if let onDone = self.onDone, text == "\n" {
				textView.resignFirstResponder()
				onDone()
				return false
			}
			return true
		}

		func textViewDidBeginEditing(_ textView: UITextView) {

		}

		func textViewDidEndEditing(_ textView: UITextView) {
			guard let onEndEditing = onEndEditing else {
				return
			}

			onEndEditing()
		}
	}
}

struct MultilineTextField: View {

	private var onCommit: (() -> Void)?
	private var placeholder: String

	@Binding private var text: String
	private var internalText: Binding<String> {
		Binding<String>(get: { self.text }) { self.text = $0 }
	}

	@State private var dynamicHeight: CGFloat = 60
	@State private var isShowingPlaceholder = true

	init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
		self.placeholder = placeholder
		self.onCommit = onCommit
		self._text = text
	}

	var body: some View {
		ZStack(alignment: .topLeading) {
			if isShowingPlaceholder {
				Text(placeholder)
					.font(.system(size: 12))
					.foregroundColor(UIApplication.shared.windows.first?.overrideUserInterfaceStyle == .dark ? .white.opacity(0.5) : Color.black.opacity(0.5))
					.padding(5)
					.padding(.top, 2)
			}

			UITextViewWrapper(
				text: self.internalText,
				calculatedHeight: $dynamicHeight,
				onDone: onCommit,
				onEditing: {
					isShowingPlaceholder = internalText.wrappedValue.isEmpty
				},
				onEndEditing: {
					isShowingPlaceholder = internalText.wrappedValue.isEmpty
				}
			)
			.frame(minHeight: abs(dynamicHeight) >= 200 ? abs(200) : abs(dynamicHeight), maxHeight: abs(dynamicHeight) >= 200 ? abs(200) : abs(dynamicHeight))
			.disableAutocorrection(true)
		}
	}
}
