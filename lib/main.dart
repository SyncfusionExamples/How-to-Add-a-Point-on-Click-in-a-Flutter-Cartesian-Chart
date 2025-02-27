import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Chart',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Line Chart'),
        ),
        body: const InteractiveChart(),
      ),
    );
  }
}

class InteractiveChart extends StatefulWidget {
  const InteractiveChart({super.key});
  @override
  InteractiveChartState createState() => InteractiveChartState();
}

class InteractiveChartState extends State<InteractiveChart> {
  late List<ChartSampleData> _chartData;
  ChartSeriesController<ChartSampleData,num>? _seriesController;

  @override
  void initState() {
    _chartData = _buildChartData();
    super.initState();
  }

  List<ChartSampleData> _buildChartData() {
    return [
      ChartSampleData(x: 1, y: 5),
      ChartSampleData(x: 2, y: 8),
      ChartSampleData(x: 3, y: 6),
      ChartSampleData(x: 4, y: 8),
      ChartSampleData(x: 5, y: 10),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildChart(),
    );
  }

  SfCartesianChart _buildChart() {
    return SfCartesianChart(
        margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
        plotAreaBorderWidth: 0,
        primaryXAxis: const NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          rangePadding: ChartRangePadding.additional,
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          rangePadding: ChartRangePadding.additional,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(width: 0),
        ),
        series: <CartesianSeries<ChartSampleData, num>>[
          LineSeries<ChartSampleData, num>(
            dataSource: _chartData,
            xValueMapper: (ChartSampleData data, int index) => data.x,
            yValueMapper: (ChartSampleData data, int index) => data.y,
            name: 'Germany',
            markerSettings: const MarkerSettings(isVisible: true),
            onRendererCreated: (controller) => _seriesController = controller,
          ),
        ],
        onChartTouchInteractionUp: (tapArgs){
          final Offset value = Offset(tapArgs.position.dx, tapArgs.position.dy);
          final CartesianChartPoint<dynamic> chartPoint = _seriesController!.pixelToPoint(value);
          _chartData.add(ChartSampleData(x: chartPoint.x, y: chartPoint.y));
          setState(() {
            
          });
        },
        );
  }

  @override
  void dispose() {
    _chartData.clear();
    super.dispose();
  }
}

class ChartSampleData {
  ChartSampleData({
    required this.x,
    required this.y,
  });
  final num? x;
  final num? y;
}