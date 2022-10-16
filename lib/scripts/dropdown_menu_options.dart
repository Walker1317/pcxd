import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> marcaList = [

  const DropdownMenuItem(
    value: 'Intel',
    child: Text('Intel'),
  ),

  const DropdownMenuItem(
    value: 'AMD',
    child: Text('AMD'),
  ),

];

List<DropdownMenuItem<String>> marcaGpuList = [

  const DropdownMenuItem(
    value: 'NVidia',
    child: Text('NVidia'),
  ),

  const DropdownMenuItem(
    value: 'AMD',
    child: Text('AMD'),
  ),

];

List<DropdownMenuItem<String>> tipoList = [

  const DropdownMenuItem(
    value: 'Low-END',
    child: Text('Low-END'),
  ),

  const DropdownMenuItem(
    value: 'Mid-END',
    child: Text('Mid-END'),
  ),

  const DropdownMenuItem(
    value: 'High-END',
    child: Text('High-END'),
  ),

];