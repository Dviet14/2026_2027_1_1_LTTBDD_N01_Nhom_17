import '../models/word.dart';
import '../models/word_set.dart';

final List<WordSet> sampleWordSets = [
  WordSet(
    id: 'tech',
    nameVi: 'Công nghệ',
    nameEn: 'Technology',
    words: [
      Word.parse(
        'database | /ˈdeɪtəbeɪs/ | cơ sở dữ liệu | Ứng dụng lưu dữ liệu người dùng trong cơ sở dữ liệu. | an organized collection of data stored on a computer | The app stores user data in a database.',
      ),
      Word.parse(
        'network | /ˈnetwɜːrk/ | mạng máy tính | Mạng của văn phòng hôm nay bị hỏng. | a group of computers or devices connected to share information | The office network is down today.',
      ),
      Word.parse(
        'device | /dɪˈvaɪs/ | thiết bị | Thiết bị này hỗ trợ hai ngôn ngữ. | a machine or tool made for a particular job | This device supports two languages.',
      ),
      Word.parse(
        'software | /ˈsɔːftwer/ | phần mềm | Chúng tôi cập nhật phần mềm mỗi tháng. | programs that tell a computer what to do | We update the software every month.',
      ),
      Word.parse(
        'keyboard | /ˈkiːbɔːrd/ | bàn phím | Bàn phím của tôi bị hỏng một phím. | a set of keys used to type on a computer | My keyboard has a broken key.',
      ),
      Word.parse(
        'password | /ˈpæswɜːrd/ | mật khẩu | Đừng chia sẻ mật khẩu của bạn. | a secret word that lets you enter an account | Do not share your password.',
      ),
      Word.parse(
        'screen | /skriːn/ | màn hình | Màn hình quá sáng. | the flat surface of a device where images appear | The screen is too bright.',
      ),
      Word.parse(
        'internet | /ˈɪntərnet/ | internet | Tôi dùng internet để học tiếng Anh. | a worldwide system that connects computers | I use the internet to study English.',
      ),
      Word.parse(
        'battery | /ˈbætəri/ | pin | Pin điện thoại của tôi gần hết. | a device that stores power for electronic things | My phone battery is almost empty.',
      ),
      Word.parse(
        'download | /ˌdaʊnˈloʊd/ | tải xuống | Vui lòng tải tệp xuống trước. | to copy a file from the internet to your device | Please download the file first.',
      ),
    ],
  ),
  WordSet(
    id: 'travel',
    nameVi: 'Du lịch',
    nameEn: 'Travel',
    words: [
      Word.parse(
        'ticket | /ˈtɪkɪt/ | vé | Tôi đã mua vé trực tuyến. | a paper or code that lets you travel or enter a place | I bought a ticket online.',
      ),
      Word.parse(
        'luggage | /ˈlʌɡɪdʒ/ | hành lý | Hành lý của cô ấy rất nặng. | bags and cases you take on a trip | Her luggage is very heavy.',
      ),
      Word.parse(
        'passport | /ˈpæspɔːrt/ | hộ chiếu | Hãy xuất trình hộ chiếu tại cổng. | an official document that lets you travel to other countries | Show your passport at the gate.',
      ),
      Word.parse(
        'hotel | /hoʊˈtel/ | khách sạn | Khách sạn ở gần bãi biển. | a place where travelers pay to sleep and stay | The hotel is near the beach.',
      ),
      Word.parse(
        'airport | /ˈerpɔːrt/ | sân bay | Chúng tôi đến sân bay sớm. | a place where planes take off and land | We arrived at the airport early.',
      ),
      Word.parse(
        'map | /mæp/ | bản đồ | Bạn đọc được bản đồ này không? | a drawing that shows where places are | Can you read this map?',
      ),
      Word.parse(
        'suitcase | /ˈsuːtkeɪs/ | va li | Anh ấy đã xếp va li tối qua. | a large case with a handle for carrying clothes | He packed his suitcase last night.',
      ),
      Word.parse(
        'tourist | /ˈtʊrɪst/ | khách du lịch | Du khách đã chụp rất nhiều ảnh. | a person who visits a place for fun | The tourist took many photos.',
      ),
      Word.parse(
        'flight | /flaɪt/ | chuyến bay | Chuyến bay của chúng tôi cất cánh lúc chín giờ. | a trip made by plane | Our flight leaves at nine.',
      ),
      Word.parse(
        'journey | /ˈdʒɜːrni/ | hành trình | Hành trình kéo dài ba tiếng. | the act of traveling from one place to another | The journey took three hours.',
      ),
    ],
  ),
  WordSet(
    id: 'daily',
    nameVi: 'Đời sống',
    nameEn: 'Daily life',
    words: [
      Word.parse(
        'breakfast | /ˈbrekfəst/ | bữa sáng | Tôi ăn sáng lúc bảy giờ. | the first meal of the day | I eat breakfast at seven.',
      ),
      Word.parse(
        'neighbor | /ˈneɪbər/ | hàng xóm | Hàng xóm của tôi rất thân thiện. | a person who lives near you | My neighbor is very friendly.',
      ),
      Word.parse(
        'umbrella | /ʌmˈbrelə/ | cái ô | Hãy mang ô, trời có thể mưa. | a tool you hold over your head to stay dry in the rain | Take an umbrella, it may rain.',
      ),
      Word.parse(
        'kitchen | /ˈkɪtʃən/ | nhà bếp | Cô ấy đang nấu ăn trong bếp. | a room where food is cooked | She is cooking in the kitchen.',
      ),
      Word.parse(
        'weather | /ˈweðər/ | thời tiết | Hôm nay thời tiết đẹp. | the condition of the air outside, such as sun, rain or wind | The weather is nice today.',
      ),
      Word.parse(
        'market | /ˈmɑːrkɪt/ | chợ | Chúng tôi mua rau ở chợ. | a place where people buy and sell food and goods | We buy vegetables at the market.',
      ),
      Word.parse(
        'bedroom | /ˈbedruːm/ | phòng ngủ | Phòng ngủ của tôi có một cửa sổ nhỏ. | a room used for sleeping | My bedroom has a small window.',
      ),
      Word.parse(
        'dinner | /ˈdɪnər/ | bữa tối | Chúng tôi ăn tối cùng nhau mỗi ngày. | the main meal eaten in the evening | We have dinner together every day.',
      ),
      Word.parse(
        'bicycle | /ˈbaɪsɪkl/ | xe đạp | Cậu ấy đạp xe đến trường. | a vehicle with two wheels that you ride by pedaling | He rides a bicycle to school.',
      ),
      Word.parse(
        'window | /ˈwɪndoʊ/ | cửa sổ | Làm ơn mở cửa sổ ra. | an opening in a wall with glass that lets in light | Please open the window.',
      ),
    ],
  ),
  WordSet(
    id: 'study',
    nameVi: 'Học tập',
    nameEn: 'Study',
    words: [
      Word.parse(
        'exam | /ɪɡˈzæm/ | kỳ thi | Kỳ thi bắt đầu lúc tám giờ. | a formal test of your knowledge | The exam starts at eight.',
      ),
      Word.parse(
        'homework | /ˈhoʊmwɜːrk/ | bài tập về nhà | Tôi làm xong bài tập về nhà trước bữa tối. | schoolwork that a student does at home | I finish my homework before dinner.',
      ),
      Word.parse(
        'teacher | /ˈtiːtʃər/ | giáo viên | Giáo viên của chúng tôi giải thích rất rõ ràng. | a person whose job is to help students learn | Our teacher explains things clearly.',
      ),
      Word.parse(
        'student | /ˈstuːdnt/ | sinh viên | Sinh viên đó đã hỏi một câu hỏi hay. | a person who studies at a school or university | The student asked a good question.',
      ),
      Word.parse(
        'library | /ˈlaɪbreri/ | thư viện | Chúng tôi học ở thư viện vào cuối tuần. | a place where books can be read or borrowed | We study in the library on weekends.',
      ),
      Word.parse(
        'notebook | /ˈnoʊtbʊk/ | vở ghi chép | Hãy viết các từ mới vào vở của bạn. | a book with empty pages for writing notes | Write the new words in your notebook.',
      ),
      Word.parse(
        'subject | /ˈsʌbdʒɪkt/ | môn học | Toán là môn học yêu thích của tôi. | an area of study taught at school | Math is my favorite subject.',
      ),
      Word.parse(
        'lecture | /ˈlektʃər/ | bài giảng | Bài giảng kéo dài hai tiếng. | a talk given to a class to teach about a topic | The lecture lasted two hours.',
      ),
      Word.parse(
        'deadline | /ˈdedlaɪn/ | hạn chót | Hạn chót nộp báo cáo là thứ Sáu. | the latest time by which something must be finished | The deadline for the report is Friday.',
      ),
      Word.parse(
        'project | /ˈprɑːdʒekt/ | dự án | Nhóm chúng tôi đang làm một dự án. | a piece of work planned to achieve a goal | Our group is working on a project.',
      ),
    ],
  ),
];
