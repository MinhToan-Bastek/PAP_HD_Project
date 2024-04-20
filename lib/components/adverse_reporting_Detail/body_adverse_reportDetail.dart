import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pap_hd/model/checkbox_createADR.dart';
import 'package:pap_hd/model/checkbox_updateReExam.dart';
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:provider/provider.dart';

class AdverseReportDetailBody extends StatefulWidget {
  final ValueChanged<bool> onToggle;
  final Map<String, dynamic> reportDetail;
  final String username;

 const AdverseReportDetailBody(
      {Key? key, required this.reportDetail, required this.username, required this.onToggle})
      : super(key: key);
  @override
  AdverseReportDetailBodyState createState() => AdverseReportDetailBodyState();
}

class AdverseReportDetailBodyState extends State<AdverseReportDetailBody> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cccdController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  bool _isReminderOn = false;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.reportDetail['TenBenhNhan'] ?? '');
    _cccdController =
        TextEditingController(text: widget.reportDetail['CCCD'] ?? '');
         _reasonController =
        TextEditingController(text: widget.reportDetail['NguyenNhan'] ?? '');
         _isReminderOn = (widget.reportDetail['TuongTacTrucTiep'] == "1");
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _nameController.dispose();
    _cccdController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Họ & tên', false, controller: _nameController),
          SizedBox(
            height: 5,
          ),
          _buildTextField('CCCD', false, controller: _cccdController),
          SizedBox(
            height: 15,
          ),
           //ElevatedButton(onPressed: createADR, child: Text('Gửi Báo Cáo')),
          _buildReminderToggle(),
         
            SizedBox(height: 5),
            _buildTextField('Nguyên nhân báo cáo', true,
                controller: _reasonController),
            //ElevatedButton(onPressed: createADR, child: Text('Gửi Báo Cáo'))
          
        ],
      ),
    );
  }

  Widget _buildTextField(String label, bool isRequired,
      {TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
       readOnly: true,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.teal, fontSize: 16),
            children: isRequired
                ? [
                    TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red, fontSize: 16))
                  ]
                : [],
          ),
        ),
        enabledBorder: _enabledBorder(),
        focusedBorder: _focusedBorder(),
        contentPadding: EdgeInsets.only(top: 15),
      ),
    );
  }

Widget _buildReminderToggle() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                    'Tương tác trực tiếp',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal
                    )
                ),
                SizedBox(width: 10), // Spacer
                if (_isReminderOn)
                  
                    IgnorePointer(
                        ignoring: true, 
                        child: Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.teal,
                            activeTrackColor: Colors.teal.shade200,
                        )
                    )
                else
                    // This switch is only interactive if `_isReminderOn` is not set by `TuongTacTrucTiep`
                    Switch(
                        value: _isReminderOn,
                        onChanged: (value) {
                            setState(() {
                                _isReminderOn = value;
                                widget.onToggle(value);
                            });
                        },
                        activeColor: Colors.teal,
                        activeTrackColor: Colors.teal.shade200,
                    )
            ],
        )
    );
}

  // Widget _buildReminderToggle() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           'Tương tác trực tiếp',
  //           style: TextStyle(
  //               fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
  //         ),
  //         SizedBox(
  //           // Đặt một khoảng trống giữa văn bản và LiteRollingSwitch
  //           width: 10, // Điều chỉnh kích thước của khoảng trống
  //         ),
  //         Transform.translate(
  //           offset: Offset(20, 0), // Điều chỉnh phép dịch chuyển sang phải
  //           child: Transform.scale(
  //             scale:
  //                 0.6, // Điều chỉnh tỉ lệ để làm cho LiteRollingSwitch nhỏ hơn
  //             child: LiteRollingSwitch(
  //               animationDuration:
  //                   Duration(milliseconds: 300), // Tốc độ của Toggle
  //               onTap: () {}, // Empty function for onTap
  //               onDoubleTap: () {}, // Empty function for onDoubleTap
  //               onSwipe: () {}, // Empty function for onSwipe
  //               onChanged: (value) {
  //           // Prevent turning off the switch if _isDirectInteraction was initially true
  //           if (_isReminderOn) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Không thể tắt tương tác trực tiếp khi đã được đặt từ trước.'))
  //             );
  //             return;
  //           }
  //           setState(() {
  //             _isReminderOn = value;
  //             widget.onToggle(value);
  //           });
  //         },
  //               //value: _isReminderOn,
  //               textOn: "",
  //               textOnColor: Colors.white,
  //               //textOff: "",
  //               colorOn: Colors.teal,
  //               //colorOff: Colors.redAccent,
  //               iconOn: Icons.done,
  //               //iconOff: CupertinoIcons.power,
  //               textSize: 16,
  //               width: 110,
                
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  UnderlineInputBorder _enabledBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
    );
  }

  UnderlineInputBorder _focusedBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal, width: 2),
    );
  }
}
