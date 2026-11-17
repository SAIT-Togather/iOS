//
//  CalendarScheduleAddView.swift
//  SAIT
//
//  Created by 이머영 on 11/15/26.
//

import SwiftUI

struct CalendarScheduleAddView: View {
    
    // MARK: - Environment
    
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Properties
    
    let initialDate: Date
    
    let onSave: (CoupleSchedule) -> Void
    
    // MARK: - State
    
    @State private var title = ""
    @State private var scheduleDate: Date
    
    // MARK: - Validation
    
    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var canSave: Bool {
        !trimmedTitle.isEmpty
    }
    
    // MARK: - Focus
    
    @FocusState private var isTitleFocused: Bool
    
    // MARK: - Initializer
    
    init(
        initialDate: Date,
        onSave: @escaping (CoupleSchedule) -> Void
    ) {
        self.initialDate = initialDate
        self.onSave = onSave
        
        let defaultDate = CalendarCalculator.date(
            bySettingHour: 19,
            minute: 0,
            for: initialDate
        )
        
        _scheduleDate = State(initialValue: defaultDate)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack {
                SAITColors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        titleSection
                        
                        dateSection
                        
                        timeSection
                        
                        informationView
                    }
                    .padding(20)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationTitle("일정 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                    .foregroundStyle(SAITColors.secondaryText)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        saveSchedule()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(
                        canSave
                            ? SAITColors.primary
                            : SAITColors.secondaryText
                    )
                    .disabled(!canSave)
                }
            }
        }
        .task {
            isTitleFocused = true
        }
    }
}

// MARK: - Form Sections

private extension CalendarScheduleAddView {
    
    var titleSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            sectionTitle("일정 제목")
            
            TextField(
                "어떤 일정을 계획하고 있나요?",
                text: $title
            )
            .font(.system(size: 15))
            .foregroundStyle(SAITColors.primaryText)
            .padding(16)
            .background(SAITColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(SAITColors.border, lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .focused($isTitleFocused)
            .submitLabel(.done)
            .onSubmit {
                isTitleFocused = false
            }
        }
    }
    
    var dateSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            sectionTitle("날짜")
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(SAITColors.primary)
                
                DatePicker(
                    "날짜 선택",
                    selection: $scheduleDate,
                    displayedComponents: .date
                )
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
            .background(SAITColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(SAITColors.border, lineWidth: 1)
            }
        }
    }
    
    var timeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            sectionTitle("시간")
            
            HStack {
                Image(systemName: "clock")
                    .foregroundStyle(SAITColors.primary)
                
                DatePicker(
                    "시간 선택",
                    selection: $scheduleDate,
                    displayedComponents: .hourAndMinute
                )
                .labelsHidden()
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
            .background(SAITColors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(SAITColors.border, lineWidth: 1)
            }
        }
    }
    
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(SAITColors.primaryText)
    }
    
}

// MARK: - Information

private extension CalendarScheduleAddView {
    
    var informationView: some View {
        HStack(alignment: .top, spacing: 10) {
            
            Image(systemName: "info.circle")
                .foregroundStyle(SAITColors.primaryText)
            
            Text("등록한 일정은 연인과 함께 확인할 수 있어요.")
                .font(.system(size: 12))
                .foregroundStyle(SAITColors.primaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(SAITColors.lightBlue)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Action

private extension CalendarScheduleAddView {
    
    func saveSchedule() {
        guard canSave else { return }
        
        isTitleFocused = false
        
        let schedule = CoupleSchedule(
            title: trimmedTitle,
            date: scheduleDate
        )
        
        onSave(schedule)
        
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    CalendarScheduleAddView(
        initialDate: Date(),
        onSave: { schedule in
            print("저장된 일정: \(schedule.title)")
        }
    )
}
