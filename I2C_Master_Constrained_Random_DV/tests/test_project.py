"""Arithmetic/structure checks ONLY; do not call these HDL simulation tests."""
import pathlib
import unittest
ROOT = pathlib.Path(__file__).resolve().parents[1]
MODE = {
    'STANDARD': (470, 400, 1000, 30, 25),
    'FAST': (130, 60, 250, 30, 10),
    'FAST_PLUS': (50, 26, 100, 30, 5),
}
class ProjectChecks(unittest.TestCase):
    def test_frequencies_for_100mhz_clk(self):
        self.assertEqual([100_000_000 // v[2] for v in MODE.values()],
                         [100_000, 400_000, 1_000_000])

    def test_all_modes_have_a_feasible_transaction(self):
        for name, (low_min, high_min, period, hold_min, setup_min) in MODE.items():
            with self.subTest(name=name):
                low, high, hold = period - high_min, high_min, hold_min
                self.assertGreaterEqual(low, low_min)
                self.assertGreaterEqual(high, high_min)
                self.assertGreaterEqual(low - hold, setup_min)
                self.assertEqual(low + high, period)

    def test_standard_setup_correction_documented(self):
        src = (ROOT/'tb/packet.sv').read_text()
        self.assertIn('scl_low_time >= sda_hold_time + 25;', src)
        self.assertIn('Corrected from screenshot', src)

    def test_each_testcase_sends_one_packet(self):
        for name in ('standard', 'fast', 'fast_plus'):
            src = (ROOT/f'testcase/i2c_{name}_test.sv').read_text()
            with self.subTest(test=name):
                self.assertEqual(src.count('send_pkt(pkt);'), 1)
                self.assertIn('wait (dut_vif.rst_n', src)

    def test_original_protected_rtl_not_bundled(self):
        self.assertFalse((ROOT/'rtl/i2c_master_control.svp').exists())

    def test_filelists_resolve(self):
        for name in ('rtl_demo.f', 'tb.f'):
            for line in (ROOT/'sim'/name).read_text().splitlines():
                line=line.strip()
                if not line or line.startswith('//') or line.startswith('+incdir+'):
                    continue
                self.assertTrue((ROOT/'sim'/line).exists(), line)

if __name__ == '__main__':
    unittest.main()
