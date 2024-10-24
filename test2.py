import subprocess
import unittest


class ProgramTest(unittest.TestCase):

    def run_program(self, input_data):
        paths = ['./main']
        res = subprocess.run(paths, input=input_data, stdout=subprocess.PIPE, stderr=subprocess.PIPE
        )
        return res

    def test_first(self):
        result = self.run_program('first\n'.encode())
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'simple text\x01')

    def test_second(self):
        result = self.run_program('Chipi\n'.encode())
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'Chipi chipi chapa chapa\x01')

    def test_empty(self):
        result = self.run_program('\n'.encode())
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'Key incorrect\n')


if __name__ == '__main__':
    unittest.main()

