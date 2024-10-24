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
        self.assertEqual(result.stdout.decode(), 'simple text')

    def test_second(self):
        result = self.run_program('second\n'.encode())
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'на русском')

    def test_empty(self):
        result = self.run_program('third\n'.encode())
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'third         word')


if __name__ == '__main__':
    unittest.main()

