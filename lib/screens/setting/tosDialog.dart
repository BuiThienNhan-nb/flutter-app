import 'package:flutter/material.dart';

class TermOfServiceDialog extends StatelessWidget {
  const TermOfServiceDialog({
    Key? key,
    required this.deviceHeight,
  }) : super(key: key);

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
                "Vui lòng đọc kỹ Thoản thuận sử dụng trước khi tiến hành tải, cài đặt, sử dụng ứng dụng hoặc các dịch vụ mà chúng tôi cung cấp."),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "1. Cập nhật",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
                "\t\t\t\t\t\tThỏa thuận này có thể cập nhật bởi nhà phát triển. Các thay đổi về điều khoản sẽ được thông báo cho người dùng sớm nhất có thể trước khi tiến hành chính thức."),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "2. Giới thiệu về ứng dụng",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
                "\t\t\t\t\t\tTravel Exploring App là ứng dụng giúp người dùng khám phá các địa điểm du lịch tại Việt Nam. Cung cấp thông tin về địa điểm, văn hóa, bản sắc,... góp phần đưa Việt Nam gần hơn với các khách du lịch."),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "3. Quyền sở hữu ứng dụng",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
                "\t\t\t\t\t\tỨng dụng được xây dựng và phát triển bởi Nhan-Long-Nghia, tất cả các quyền sở hữu liên quan về mã nguồn, dữ liệu, thông tin, nội dung đều không được phép sao chép, tái tạo, phân phối nếu không có sự cho phép từ chủ sở hữu."),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "4. Truy cập thông tin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
                "\t\t\t\t\t\tKhi sử dụng ứng dụng, bạn thừa nhận rằng chúng tôi có quyền sử dụng những API của hệ thống để truy cập vào bộ sư tập, máy ảnh, Gmail, Internet từ thiết bị của bạn. Tất cả các sự truy cập này đều được thực hiện sau khi có sự đồng ý của bạn."),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "5. Cam kết bảo mật thông tin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
                "\t\t\t\t\t\tỨng dụng chúng tôi cam kết giữ bí mật tất cả thông tin mà bạn cung cấp, hoặc thu thập từ bạn và không tiết lộ với bất kỳ bên thứ ba nào trừ khi có yêu cầu từ Cơ quan Nhà nước có thẩm quyền."),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "6. Phí và các khoản thu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
                "\t\t\t\t\t\Ứng dụng cam kết không thu bất kỳ khoản phí nào từ người dùng cho các dịch vụ cơ bản mà chúng tôi đang cung cấp."),
            Container(
              alignment: Alignment.centerRight,
              child: CloseButton(),
            ),
          ],
        ),
      ),
    );
  }
}
