import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({Key? key}) : super(key: key);

  @override
  _CalendarioScreenState createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  late DateTime _currentDate;
  final TextEditingController _recaidaController = TextEditingController();
  bool _localeInitialized = false;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting('es', null);
    setState(() {
      _localeInitialized = true;
    });
  }

  @override
  void dispose() {
    _recaidaController.dispose();
    super.dispose();
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  void _changeMonth(int increment) {
    setState(() {
      _currentDate = DateTime(
        _currentDate.year,
        _currentDate.month + increment,
      );
    });
  }

  String _getMonthName(int month) {
    if (!_localeInitialized) return '';
    return DateFormat('MMMM', 'es').format(DateTime(2024, month));
  }

  @override
  Widget build(BuildContext context) {
    if (!_localeInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(220, 100, 0, 150),
            Color.fromARGB(220, 0, 0, 90),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Control de adicciones',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            _buildMonthSelector(),
            _buildCalendar(),
            _buildRecaidasInput()
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _changeMonth(-1),
          ),
          Text(
            '${_getMonthName(_currentDate.month)} ${_currentDate.year}',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final daysInMonth = _daysInMonth(_currentDate.year, _currentDate.month);
    final firstDayOfWeek =
        DateTime(_currentDate.year, _currentDate.month, 1).weekday % 7;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWeekDaysHeader(),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: 42,
                itemBuilder: (context, index) {
                  if (index < firstDayOfWeek ||
                      index >= firstDayOfWeek + daysInMonth) {
                    return const SizedBox();
                  }
                  final day = index - firstDayOfWeek + 1;
                  return _buildDayCell(day);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekDaysHeader() {
    final weekDays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map((day) => Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDayCell(int day) {
    final isToday = DateTime.now().year == _currentDate.year &&
        DateTime.now().month == _currentDate.month &&
        DateTime.now().day == day;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.0)),
        borderRadius: BorderRadius.circular(8),
        color: isToday
            ? const Color.fromARGB(255, 142, 139, 139).withOpacity(1)
            : null,
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildRecaidasInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recaídas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _recaidaController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor:
                  const Color.fromARGB(255, 142, 139, 139).withOpacity(1),
              hintText: "Describe tu experiencia aquí...",
              hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255)
                      .withOpacity(0.9)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 142, 139, 139)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 91, 90, 90)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 0, 0), width: 1),
              ),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildRachasButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // Implementar la lógica de rachas aquí
        },
        icon: const Icon(Icons.timeline, color: Colors.white),
        label: const Text('Ver Rachas', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
