import 'dart:convert';

import 'package:flutter_base_app/features/harvest_calculator/presentation/models/simulation_results_models.dart';

/// Utility class for building ECharts options.
class ChartBuilder {
  ChartBuilder._();

  /// Builds ECharts option string for biomass chart.
  static String buildBiomassChartOption(List<BiomassChartPoint> points) {
    final docs = points.map((p) => p.doc).toList();
    final biomass = points.map((p) => p.biomass).toList();
    final capacity = points.map((p) => p.capacity).toList();
    final feed = points.map((p) => p.feedCumulative).toList();
    final partialHarvests = points
        .where((p) => p.harvestPercentage != null)
        .map(
          (p) => {
            'coord': [p.doc, p.biomass],
            'value': '${p.harvestPercentage!.toStringAsFixed(0)}%',
            'itemStyle': {'color': '#FA6619'},
          },
        )
        .toList();

    return '''
  {
    grid: { left: 55, right: 16, top: 16, bottom: 45 },
    axisPointer: {
      show: true,
      type: 'cross',
      snap: true,
      lineStyle: {
        color: '#1E3A8A',
        type: 'dashed'
      },
      label: {
        backgroundColor: '#FFFFFF',
        borderColor: '#E5E7EB',
        borderWidth: 1,
        color: '#111827',
        padding: [4, 10],
        formatter: function (params) {
          if (params.axisDimension === 'y') {
            return params.value.toFixed(1) + ' kg';
          }
          return 'DoC ' + params.value;
        }
      }
    },
    color: ['#1D4ED8', '#F97316', '#22C55E'],
    legend: { show: false },
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'cross' },
      backgroundColor: '#FFFFFF',
      borderColor: '#E5E7EB',
      borderWidth: 1,
      textStyle: { color: '#111827' },
    },
    xAxis: {
      type: 'category',
      data: ${jsonEncode(docs)},
      boundaryGap: false,
      name: 'DoC (Hari)',
      nameLocation: 'middle',
      nameGap: 32,
      nameTextStyle: {
        fontFamily: 'Open Sans',
        fontSize: 12,
        color: '#4A4A4A'
      },
      axisLine: { lineStyle: { color: '#CFCFCF' } }
    },
    yAxis: {
      type: 'value',
      name: 'Berat (kg)',
      nameLocation: 'middle',
      nameGap: 40,
      nameTextStyle: {
        fontFamily: 'Open Sans',
        fontSize: 12,
        color: '#4A4A4A'
      },
      axisLine: { show: false },
      splitLine: { lineStyle: { color: '#ECECEC' } },
      axisPointer: {
        show: true,
        label: {
          backgroundColor: '#FFFFFF',
          borderColor: '#E5E7EB',
          borderWidth: 1,
          shadowColor: 'rgba(15, 23, 42, 0.08)',
          shadowBlur: 12,
          color: '#111827',
          padding: [6, 12],
          formatter: function (params) {
            return params.value.toFixed(1) + ' kg';
          }
        }
      }
    },
    series: [
      {
        name: 'Biomassa',
        type: 'line',
        smooth: true,
        showSymbol: false,
        areaStyle: { opacity: 0.08 },
        data: ${jsonEncode(biomass)},
        markPoint: { data: ${jsonEncode(partialHarvests)} }
      },
      {
        name: 'Kapasitas Maks. Kolam',
        type: 'line',
        smooth: true,
        showSymbol: false,
        lineStyle: { type: 'dashed' },
        data: ${jsonEncode(capacity)}
      },
      {
        name: 'Pakan Kumulatif',
        type: 'line',
        smooth: true,
        showSymbol: false,
        data: ${jsonEncode(feed)}
      }
    ]
  }
  ''';
  }

  /// Builds ECharts option string for feed vs revenue chart.
  static String buildFeedChartOption(List<FeedChartPoint> points) {
    final docs = points.map((p) => p.doc).toList();
    final revenue = points.map((p) => p.revenue).toList();
    final feed = points.map((p) => p.feed).toList();

    return '''
  {
    grid: { left: 75, right: 16, top: 16, bottom: 45 },
    axisPointer: {
      show: true,
      type: 'cross',
      snap: true,
      lineStyle: {
        color: '#1E3A8A',
        type: 'dashed'
      },
      label: {
        backgroundColor: '#FFFFFF',
        borderColor: '#E5E7EB',
        borderWidth: 1,
        color: '#111827',
        padding: [4, 10],
        formatter: function (params) {
          if (params.axisDimension === 'y') {
            if (params.value >= 1000) {
              return (params.value / 1000).toFixed(0) + 'k';
            }
            return params.value + '';
          }
          return 'DoC ' + params.value;
        }
      }
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'cross' },
      backgroundColor: '#FFFFFF',
      borderColor: '#E5E7EB',
      borderWidth: 1,
      textStyle: { color: '#111827' },
    },
    color: ['#60A5FA', '#FDBA74'],
    legend: { show: false },
    xAxis: {
      type: 'category',
      data: ${jsonEncode(docs)},
      boundaryGap: false,
      name: 'DoC (Hari)',
      nameLocation: 'middle',
      nameGap: 32,
      nameTextStyle: {
        fontFamily: 'Open Sans',
        fontSize: 12,
        color: '#4A4A4A'
      },
      axisLine: { lineStyle: { color: '#CFCFCF' } }
    },
    yAxis: {
      type: 'value',
      name: 'Value (RP)',
      nameLocation: 'middle',
      nameGap: 60,
      nameTextStyle: {
        fontFamily: 'Open Sans',
        fontSize: 12,
        color: '#4A4A4A'
      },
      axisLine: { show: false },
      splitLine: { lineStyle: { color: '#ECECEC' } },
      axisLabel: {
        formatter: function (value) {
          if (value >= 1000) {
            return (value / 1000).toFixed(0) + 'k';
          }
          return value;
        }
      },
      axisPointer: {
        show: true,
        label: {
          backgroundColor: '#FFFFFF',
          borderColor: '#E5E7EB',
          borderWidth: 1,
          shadowColor: 'rgba(15, 23, 42, 0.08)',
          shadowBlur: 12,
          color: '#111827',
          padding: [6, 12],
          formatter: function (params) {
            if (params.value >= 1000) {
              return 'Rp ' + (params.value / 1000).toFixed(0) + 'k';
            }
            return 'Rp ' + params.value;
          },
        }
      }
    },
    series: [
      {
        name: 'Potensi Pendapatan',
        type: 'line',
        smooth: true,
        showSymbol: false,
        areaStyle: { opacity: 0.2 },
        data: ${jsonEncode(revenue)}
      },
      {
        name: 'Pengeluaran Pakan Kumulatif',
        type: 'line',
        smooth: true,
        showSymbol: false,
        areaStyle: { opacity: 0.15 },
        data: ${jsonEncode(feed)}
      }
    ]
  }
  ''';
  }
}
