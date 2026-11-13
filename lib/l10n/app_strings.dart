class AppStrings {
  static const Map<String, Map<String, String>> _values = {
    'vi': {
      'appTitle': 'VocabMaster - Học từ vựng',
      'language': 'Ngôn ngữ',
      'welcome': 'Hôm nay bạn muốn học gì?',
      'hello': 'Xin chào',

      // Tài khoản
      'login': 'Đăng nhập',
      'register': 'Đăng ký',
      'fullName': 'Họ và tên',
      'email': 'Email',
      'username': 'Tên đăng nhập',
      'password': 'Mật khẩu',
      'confirmPassword': 'Nhập lại mật khẩu',
      'noAccount': 'Chưa có tài khoản? Đăng ký',
      'logout': 'Đăng xuất',
      'registerSuccess': 'Đăng ký thành công. Chào mừng bạn.',
      'simulatedNote': 'Tài khoản mô phỏng, dữ liệu sẽ mất khi đóng ứng dụng.',

      // Cài đặt tài khoản
      'accountSettings': 'Tài khoản',
      'accountInfo': 'Thông tin tài khoản',
      'accountInfoDesc': 'Chỉnh sửa họ tên hoặc mật khẩu',
      'passwordSettings': 'Thay đổi mật khẩu (không bắt buộc)',
      'currentPassword': 'Mật khẩu hiện tại',
      'newPassword': 'Mật khẩu mới',
      'confirmNewPassword': 'Xác nhận mật khẩu mới',
      'passwordOptionalHint':
          'Để trống các ô mật khẩu nếu chỉ muốn đổi họ tên.',
      'saveChanges': 'Lưu thay đổi',
      'cancel': 'Hủy',
      'accountUpdated': 'Đã cập nhật thông tin tài khoản',

      // Avatar
      'avatarHint': 'Chạm vào ảnh để thay đổi ảnh đại diện',
      'chooseAvatar': 'Chọn ảnh đại diện',
      'uploadAvatar': 'Tải ảnh từ thiết bị',
      'useInitialAvatar': 'Dùng chữ cái đầu của tên',
      'maleAvatar': 'Nhân vật nam',
      'femaleAvatar': 'Nhân vật nữ',
      'avatar': 'Ảnh đại diện',
      'avatarUpdated': 'Đã cập nhật ảnh đại diện',

      // Giao diện
      'theme': 'Giao diện',
      'lightTheme': 'Sáng',
      'darkTheme': 'Tối',
      'settings': 'Cài đặt',
      'settingsDesc': 'Tài khoản, giao diện và ngôn ngữ',

      // Từ vựng
      'wordSets': 'Bộ từ vựng',
      'wordSetsDesc': 'Chọn một chủ đề để bắt đầu học',
      'noWordSets': 'Chưa có bộ từ nào',
      'words': 'từ',
      'tapToFlip': 'Chạm vào thẻ để lật',
      'previous': 'Trước',
      'next': 'Tiếp',
      'markKnown': 'Đã thuộc',
      'unmarkKnown': 'Bỏ đánh dấu',
      'knownCount': 'Đã thuộc',

      // Quiz
      'quiz': 'Kiểm tra từ vựng',
      'quizDesc': 'Làm bài trắc nghiệm theo chủ đề đã học',
      'quizChooseSet': 'Chọn chủ đề để kiểm tra',
      'startQuiz': 'Làm quiz',
      'question': 'Câu',
      'quizPrompt': 'Nghĩa của từ này là gì?',
      'finish': 'Xem kết quả',
      'timeUp': 'Hết giờ!',
      'result': 'Kết quả',
      'points': 'Điểm',
      'correctCount': 'Số câu đúng',
      'playAgain': 'Làm lại',
      'backHome': 'Về trang chủ',
      'resultGreat': 'Rất tốt! Bạn nắm vững bộ từ này.',
      'resultOk': 'Khá ổn. Hãy ôn thêm vài từ nữa.',
      'resultTry': 'Cần cố gắng hơn. Hãy học lại bằng flashcard.',

      // Sổ tay từ khó
      'savedWordsTitle': 'Sổ tay từ khó',
      'savedWordsDesc': 'Các từ bạn đã lưu hoặc làm sai trong quiz',
      'saveWord': 'Lưu vào sổ tay',
      'unsaveWord': 'Bỏ khỏi sổ tay',
      'noSavedWords': 'Sổ tay đang trống. Lưu từ bằng ngôi sao hoặc làm quiz để thêm từ sai.',
      'savedHint':
          'Từ làm sai trong quiz tự động vào đây. Gạt sang trái để xóa.',

      // Tìm kiếm
      'search': 'Tìm kiếm từ',
      'searchDesc': 'Tìm theo từ tiếng Anh, nghĩa hoặc định nghĩa',
      'searchHint': 'Nhập từ cần tìm',
      'noResults': 'Không tìm thấy kết quả',

      // Thống kê
      'statsTitle': 'Thống kê học tập',
      'statsDesc': 'Tiến độ và điểm quiz theo chủ đề',
      'overall': 'Tổng quan',
      'totalKnown': 'Từ đã thuộc',
      'savedCount': 'Từ trong sổ tay',
      'avgScore': 'Điểm quiz trung bình',
      'notTaken': 'Chưa làm quiz',
      'byTopic': 'Theo chủ đề',
      'bestScore': 'Điểm cao nhất',

      // Thông tin nhóm
      'about': 'Giới thiệu',
      'aboutDesc': 'Thông tin nhóm thực hiện',
      'teamInfo': 'Thông tin nhóm',
      'memberName': 'Họ tên',
      'studentId': 'Mã sinh viên',
      'className': 'Lớp',
      'course': 'Môn học',
      'courseName': 'Lập trình thiết bị di động',
      'github': 'Mã nguồn',

      // Thông báo lỗi
      'errEmpty': 'Vui lòng nhập đầy đủ thông tin',
      'errNameShort': 'Họ tên phải có ít nhất 2 ký tự',
      'errEmailInvalid': 'Email không đúng định dạng',
      'errEmailExists': 'Email này đã được đăng ký',
      'errWrongCredentials': 'Email hoặc mật khẩu không chính xác',
      'errPasswordShort': 'Mật khẩu phải có ít nhất 6 ký tự',
      'errPasswordMismatch': 'Mật khẩu xác nhận không khớp',
      'errNotLoggedIn': 'Bạn chưa đăng nhập',
      'errWrongCurrentPassword': 'Mật khẩu hiện tại không đúng',
      'errCurrentPasswordRequired':
          'Vui lòng nhập mật khẩu hiện tại để đổi mật khẩu',
      'errInvalidImage': 'Không thể đọc ảnh. Vui lòng chọn ảnh khác.',
      'errAvatarTooLarge': 'Ảnh đại diện phải nhỏ hơn 5 MB',

      // Hiện / ẩn mật khẩu
      'showPassword': 'Hiện mật khẩu',
      'hidePassword': 'Ẩn mật khẩu',

      // So tay tu kho va phat am
      'reviewSaved': 'Ôn tập sổ tay',
      'reviewSavedDesc': 'Làm quiz từ những từ trong sổ tay',
      'reviewNeedsTwo': 'Cần ít nhất 2 từ để tạo bài ôn tập',
      'listenPronunciation': 'Nghe phát âm',

      // Muc tieu hoc tap hang ngay
      'dailyGoalTitle': 'Mục tiêu hôm nay',
      'dailyGoalDesc': 'Số từ đã đánh dấu thuộc hôm nay',
      'wordsPerDay': 'từ/ngày',
      'chooseDailyGoal': 'Chọn mục tiêu mỗi ngày',
      'dailyGoalAchieved': 'Bạn đã hoàn thành mục tiêu hôm nay!',
    },

    'en': {
      'appTitle': 'VocabMaster - Vocabulary',
      'language': 'Language',
      'welcome': 'What do you want to learn today?',
      'hello': 'Hello',

      // Account
      'login': 'Log in',
      'register': 'Register',
      'fullName': 'Full name',
      'email': 'Email',
      'username': 'Username',
      'password': 'Password',
      'confirmPassword': 'Confirm password',
      'noAccount': 'No account yet? Register',
      'logout': 'Log out',
      'registerSuccess': 'Registration successful. Welcome.',
      'simulatedNote': 'Demo account only. Data is lost when the app closes.',

      // Account settings
      'accountSettings': 'Account',
      'accountInfo': 'Account information',
      'accountInfoDesc': 'Edit your name or password',
      'passwordSettings': 'Change password (optional)',
      'currentPassword': 'Current password',
      'newPassword': 'New password',
      'confirmNewPassword': 'Confirm new password',
      'passwordOptionalHint':
          'Leave password fields empty if you only want to change your name.',
      'saveChanges': 'Save changes',
      'cancel': 'Cancel',
      'accountUpdated': 'Account information updated',

      // Avatar
      'avatarHint': 'Tap the picture to change your avatar',
      'chooseAvatar': 'Choose an avatar',
      'uploadAvatar': 'Upload an image from device',
      'useInitialAvatar': 'Use the first letter of your name',
      'maleAvatar': 'Male character',
      'femaleAvatar': 'Female character',
      'avatar': 'Avatar',
      'avatarUpdated': 'Avatar updated',

      // Appearance
      'theme': 'Appearance',
      'lightTheme': 'Light',
      'darkTheme': 'Dark',
      'settings': 'Settings',
      'settingsDesc': 'Account, appearance and language',

      // Vocabulary
      'wordSets': 'Word sets',
      'wordSetsDesc': 'Pick a topic to start learning',
      'noWordSets': 'No word sets yet',
      'words': 'words',
      'tapToFlip': 'Tap the card to flip',
      'previous': 'Previous',
      'next': 'Next',
      'markKnown': 'I know it',
      'unmarkKnown': 'Unmark',
      'knownCount': 'Known',

      // Quiz
      'quiz': 'Vocabulary quiz',
      'quizDesc': 'Take a quiz based on a word topic',
      'quizChooseSet': 'Choose a topic for the quiz',
      'startQuiz': 'Take quiz',
      'question': 'Question',
      'quizPrompt': 'Which definition matches this word?',
      'finish': 'See results',
      'timeUp': 'Time is up!',
      'result': 'Result',
      'points': 'Points',
      'correctCount': 'Correct answers',
      'playAgain': 'Play again',
      'backHome': 'Back to home',
      'resultGreat': 'Great! You know this set well.',
      'resultOk': 'Not bad. Review a few more words.',
      'resultTry': 'Keep trying. Study again with flashcards.',

      // Saved words
      'savedWordsTitle': 'Hard words',
      'savedWordsDesc': 'Words you saved or got wrong in quizzes',
      'saveWord': 'Save to notebook',
      'unsaveWord': 'Remove from notebook',
      'noSavedWords': 'Your notebook is empty. Save words with the star or take a quiz to collect wrong ones.',
      'savedHint':
          'Words you miss in quizzes are added here. Swipe left to remove.',

      // Search
      'search': 'Search words',
      'searchDesc': 'Search by word, meaning or definition',
      'searchHint': 'Type a word to search',
      'noResults': 'No results found',

      // Statistics
      'statsTitle': 'Study statistics',
      'statsDesc': 'Progress and quiz scores by topic',
      'overall': 'Overview',
      'totalKnown': 'Words known',
      'savedCount': 'Words in notebook',
      'avgScore': 'Average quiz score',
      'notTaken': 'No quiz yet',
      'byTopic': 'By topic',
      'bestScore': 'Best score',

      // Team information
      'about': 'About',
      'aboutDesc': 'Team information',
      'teamInfo': 'Team information',
      'memberName': 'Full name',
      'studentId': 'Student ID',
      'className': 'Class',
      'course': 'Course',
      'courseName': 'Mobile Application Development',
      'github': 'Source code',

      // Error messages
      'errEmpty': 'Please fill in all required fields',
      'errNameShort': 'Name must contain at least 2 characters',
      'errEmailInvalid': 'Invalid email address',
      'errEmailExists': 'This email has already been registered',
      'errWrongCredentials': 'Incorrect email or password',
      'errPasswordShort': 'Password must contain at least 6 characters',
      'errPasswordMismatch': 'Passwords do not match',
      'errNotLoggedIn': 'You are not logged in',
      'errWrongCurrentPassword': 'Current password is incorrect',
      'errCurrentPasswordRequired': 'Enter your current password to change it',
      'errInvalidImage': 'Unable to read image. Please choose another image.',
      'errAvatarTooLarge': 'Avatar image must be smaller than 5 MB',

      // Show / hide password
      'showPassword': 'Show password',
      'hidePassword': 'Hide password',
      // Saved words and pronunciation
      'reviewSaved': 'Review notebook',
      'reviewSavedDesc': 'Take a quiz using saved words',
      'reviewNeedsTwo': 'At least 2 saved words are needed to start a review',
      'listenPronunciation': 'Listen to pronunciation',

      // Daily study goal
      'dailyGoalTitle': 'Daily goal',
      'dailyGoalDesc': 'Words marked as known today',
      'wordsPerDay': 'words/day',
      'chooseDailyGoal': 'Choose a daily goal',
      'dailyGoalAchieved': "You have reached today's goal!",
    },
  };

  final String languageCode;

  const AppStrings(this.languageCode);

  String get(String key) {
    return _values[languageCode]?[key] ?? key;
  }
}
