// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:tlego_world/assets/color/colors.dart';
import 'package:tlego_world/services/api_service.dart';

class LocationDropDown extends StatefulWidget {
  final Function(String) onProvinceSelected;
  final Function(String) onDistrictSelected;
  final Function(String) onWardSelected;

  const LocationDropDown({
    super.key,
    required this.onProvinceSelected,
    required this.onDistrictSelected,
    required this.onWardSelected,
  });

  @override
  State<LocationDropDown> createState() => _LocationDropDownState();
}

class _LocationDropDownState extends State<LocationDropDown> {
  List<dynamic> provinces = [];
  List<dynamic> districts = [];
  List<dynamic> wards = [];

  String? selectedProvince;
  String? selectedDistrict;
  String? selectedWard;

  @override
  void initState() {
    super.initState();
    loadProvinces();
  }

  // Gọi API để lấy danh sách tỉnh/thành phố
  Future<void> loadProvinces() async {
    try {
      final data = await ApiService.getProvinces();
      setState(() {
        provinces = data;
      });
    } catch (error) {
      print("Lỗi tải tỉnh/thành: $error");
    }
  }

  // Khi chọn tỉnh/thành, tải danh sách quận/huyện
  Future<void> loadDistricts(String provinceId) async {
    try {
      final data = await ApiService.getDistricts(provinceId);
      setState(() {
        districts = data;
        selectedDistrict = null;
        selectedWard = null;
        wards = [];
      });
    } catch (error) {
      print("Lỗi tải quận/huyện: $error");
    }
  }

  // Khi chọn quận/huyện, tải danh sách phường/xã
  Future<void> loadWards(int districtId) async {
    try {
      final data = await ApiService.getWards(districtId);
      setState(() {
        wards = data;
        selectedWard = null;
      });
    } catch (error) {
      print("Lỗi tải phường/xã: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown chọn Tỉnh/Thành phố
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: "Chọn Tỉnh/Thành phố",
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
          ),
          value: selectedProvince,
          items: provinces.map((province) {
            return DropdownMenuItem<String>(
              value: province['code'].toString(),
              child: Text(province['name']),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedProvince = newValue;
              selectedDistrict = null;
              selectedWard = null;
              districts = [];
              wards = [];
            });
            loadDistricts(newValue!);
            // Tìm tên của tỉnh/thành phố dựa trên 'code'
            String provinceName = provinces
                .firstWhere((p) => p['code'].toString() == newValue)['name'];

            widget.onProvinceSelected(provinceName);
          },
        ),
        const SizedBox(height: 16),

        // Dropdown chọn Quận/Huyện
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: "Chọn Quận/Huyện",
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
          ),
          value: selectedDistrict,
          items: districts.map((district) {
            return DropdownMenuItem<String>(
              value: district['code'].toString(),
              child: Text(district['name']),
            );
          }).toList(),
          onChanged: selectedProvince == null
              ? null
              : (newValue) {
                  setState(() {
                    selectedDistrict = newValue;
                    selectedWard = null;
                    wards = [];
                  });
                  loadWards(int.parse(newValue!));

                  String districtName = districts.firstWhere(
                      (p) => p['code'].toString() == newValue)['name'];

                  widget.onDistrictSelected(districtName);
                },
        ),
        const SizedBox(height: 16),

        // Dropdown chọn Phường/Xã
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: "Chọn Phường/Xã",
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
          ),
          value: selectedWard,
          items: wards.map((ward) {
            return DropdownMenuItem<String>(
              value: ward['code'].toString(),
              child: Text(ward['name']),
            );
          }).toList(),
          onChanged: selectedDistrict == null
              ? null
              : (newValue) {
                  setState(() {
                    selectedWard = newValue;
                  });

                  String wardName = wards.firstWhere(
                      (p) => p['code'].toString() == newValue)['name'];

                  widget.onWardSelected(wardName);
                },
        ),
      ],
    );
  }
}
