// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/components/app_bar.dart';
import 'package:tlego_world/components/box_info.dart';
import 'package:tlego_world/components/component/button.dart';
import 'package:tlego_world/components/product_element.dart';
import 'package:tlego_world/feature/create/components/dropdown_field.dart';
import 'package:tlego_world/services/product_service.dart';

class UnloginInfo extends StatefulWidget {
  final String proID;
  final int proQuantity;
  const UnloginInfo(
      {super.key, required this.proID, required this.proQuantity});

  @override
  State<UnloginInfo> createState() => _UnloginInfoState();
}

class _UnloginInfoState extends State<UnloginInfo> {
  late Future<Map<String, dynamic>?> _proFuture;

  @override
  void initState() {
    super.initState();
    _proFuture = ProductService.getProByID(widget.proID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: AppColor.lightGray.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 4),
            )
          ]),
          child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const AppBarTitle(title: 'GIỎ HÀNG CỦA BẠN')),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
          width: double.infinity,
          child: FutureBuilder<Map<String, dynamic>?>(
            future: _proFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Lỗi: ${snapshot.error}"));
              }

              final product = snapshot.data;
              if (product == null) {
                return const Center(child: Text("Không tìm thấy sản phẩm"));
              }

              // /// Tính tổng tiền và tổng số lượng sản phẩm
              // double newTotalPrice = products.fold(0, (sum, item) {
              //   final price =
              //       double.tryParse(item["pro_price"].toString()) ?? 0;
              //   final quantity = widget.proQuantity;
              //   return sum + (price * quantity);
              // });

              // int newTotalProduct = products.fold(0, (sum, item) {
              //   final quantity =
              //       int.tryParse(item["pro_quantity"].toString()) ?? 0;
              //   return sum + quantity;
              // });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  BoxInfo(
                    title: 'Chi tiết đơn hàng',
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.lightGray),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Dash(
                              length: MediaQuery.of(context).size.width - 98,
                              dashColor: AppColor.lightGray,
                            ),
                          ),
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          final item = product;

                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.network(
                                      item['pro_img'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['pro_name'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColor.mateGray,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Số lượng: ${widget.proQuantity.toString()}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColor.normalGray,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          formatCurrency(item['pro_price']),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const InfoForm(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class InfoForm extends StatefulWidget {
  const InfoForm({super.key});

  @override
  State<InfoForm> createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _selectedProvices = '';
  String _selectedDistrict = '';
  String _selectedWard = '';

  void _handleSubmit() {
    String phone = _phoneController.text.trim();
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();

    print("Số điện thoại: $phone");
    print("Họ và tên: $name");
    print(
        "Địa chỉ: $address, $_selectedWard, $_selectedDistrict, $_selectedProvices");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thông tin người mua',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.normalGray),
        ),
        const SizedBox(height: 16),
        // Số điện thoại
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
            floatingLabelStyle:
                const TextStyle(fontSize: 16, color: AppColor.darkBlue),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.lightGray),
                borderRadius: BorderRadius.circular(24)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.darkBlue),
                borderRadius: BorderRadius.circular(24)),
            labelText: 'Số điện thoại',
            labelStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle:
                const TextStyle(fontSize: 14, color: AppColor.normalGray),
            hintText: 'Điền số điện thoại người nhận hàng',
            floatingLabelAlignment: FloatingLabelAlignment.start,
          ),
        ),

        const SizedBox(
          height: 12,
        ),
        // Họ và tên
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            floatingLabelStyle:
                const TextStyle(fontSize: 16, color: AppColor.darkBlue),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.lightGray),
                borderRadius: BorderRadius.circular(24)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.darkBlue),
                borderRadius: BorderRadius.circular(24)),
            labelText: 'Họ và tên',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle:
                const TextStyle(fontSize: 14, color: AppColor.normalGray),
            hintText: 'Điền họ và tên người nhận hàng',
            floatingLabelAlignment: FloatingLabelAlignment.start,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Địa chỉ giao hàng',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.normalGray),
        ),
        const SizedBox(height: 16),
        LocationDropDown(
          onProvinceSelected: (String province) {
            setState(() {
              _selectedProvices = province;
            });
          },
          onDistrictSelected: (String district) {
            setState(() {
              _selectedDistrict = district;
            });
          },
          onWardSelected: (String ward) {
            setState(() {
              _selectedWard = ward;
            });
          },
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _addressController,
          decoration: InputDecoration(
            floatingLabelStyle:
                const TextStyle(fontSize: 16, color: AppColor.darkBlue),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.lightGray),
                borderRadius: BorderRadius.circular(24)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.darkBlue),
                borderRadius: BorderRadius.circular(24)),
            labelText: 'Số nhà và tên đường',
            labelStyle: const TextStyle(fontSize: 14),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle:
                const TextStyle(fontSize: 14, color: AppColor.normalGray),
            hintText: 'Số 123/2/3, đường Nguyễn Thị Minh Khai',
            floatingLabelAlignment: FloatingLabelAlignment.start,
          ),
        ),
        const SizedBox(height: 16),
        RedButton(onPressed: () => _handleSubmit(), text: 'TIẾP THEO')
      ],
    );
  }
}
