//
//  RatingView.swift
//  BookWorm
//
//  Created by Venkatesh Nyamagoudar on 6/1/23.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maxStar = 5
    
    var offImage: Image?
    var onImage: Image = Image(systemName: "star.fill")
    
    var onColor: Color = Color.yellow
    var offColor: Color = Color.gray
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maxStar+1,id: \.self) { number in
                image(for: number)
                    .foregroundColor(number>rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
//                    .accessibilityLabel("\(number == 1 ? "1 star" : "\(number) stars")")
//                    .accessibilityRemoveTraits(.isImage)
//                    .accessibilityAddTraits(number > rating ? .isButton : [.isButton, .isSelected])
            }
        }
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maxStar { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number>rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(2))
    }
}
