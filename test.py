import unittest
import subprocess


class Test(unittest.TestCase):

    def run_program(self, input_data):
        result = subprocess.run(['./program'], input=input_data, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        return result

    def test_first(self):
        result = self.run_program('first\n')
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'simple text')

    def test_second(self):
        result = self.run_program('second\n')
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'на русском')

    def test_third(self):
        result = self.run_program('third\n')
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'third         word')

    def test_empty(self):
        result = self.run_program('\n')
        self.assertEqual(result.stderr.decode(), "")
        self.assertEqual(result.stdout.decode(), 'key is empty')


if __name__ == '__main__':
    unittest.main()
