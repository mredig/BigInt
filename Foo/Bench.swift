//
//  Bench.swift
//  BigInt
//
//  Created by Michael Redig on 11/7/24.
//

import BenchyLib
import BigInt
import Foundation

@main
struct Bench {
	static func main() throws {
		var benchy = Benchy()
		try benchy.addBenchyTest(DecimalIniter.self)

		try benchy.runBenchmarks()

		benchy.displayResults(decimalCount: 10)
	}
}

enum DecimalIniter: BenchyComparator {
	static var benchmarks: [ChildBenchmark] = []
	static var iterations: Int = 999999

	static func setupBenchmarks() throws {
		let bench = { (i: Int, label: String) in
			_ = BigUInt(exactly: Decimal(0)) == 0
			_ = BigUInt(exactly: Decimal(Double.nan)) == nil
			_ = BigUInt(exactly: Decimal(10)) == 10
			_ = BigUInt(exactly: Decimal(1000)) == 1000
			_ = BigUInt(exactly: Decimal(1000.1)) == nil
			_ = BigUInt(exactly: Decimal(1000.9)) == nil
			_ = BigUInt(exactly: Decimal(1001.5)) == nil
			_ = BigUInt(exactly: Decimal(UInt.max) + 5) == "18446744073709551620"
			_ = BigUInt(exactly: (Decimal(UInt.max) + 5.5)) == nil
			_ = BigUInt(exactly: Decimal.greatestFiniteMagnitude) == "3402823669209384634633746074317682114550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
			_ = BigUInt(truncating: Decimal(0)) == 0
			_ = BigUInt(truncating: Decimal(Double.nan)) == nil
			_ = BigUInt(truncating: Decimal(10)) == 10
			_ = BigUInt(truncating: Decimal(1000)) == 1000
			_ = BigUInt(truncating: Decimal(1000.1)) == 1000
			_ = BigUInt(truncating: Decimal(1000.9)) == 1000
			_ = BigUInt(truncating: Decimal(1001.5)) == 1001
			_ = BigUInt(truncating: Decimal(UInt.max) + 5) == "18446744073709551620"
			_ = BigUInt(truncating: (Decimal(UInt.max) + 5.5)) == "18446744073709551620"

			_ = BigUInt(exactly: -Decimal(10)) == nil
			_ = BigUInt(exactly: -Decimal(1000)) == nil
			_ = BigUInt(exactly: -Decimal(1000.1)) == nil
			_ = BigUInt(exactly: -Decimal(1000.9)) == nil
			_ = BigUInt(exactly: -Decimal(1001.5)) == nil
			_ = BigUInt(exactly: -Decimal(UInt.max) + 5) == nil
			_ = BigUInt(exactly: -(Decimal(UInt.max) + 5.5)) == nil
			_ = BigUInt(exactly: Decimal.leastFiniteMagnitude) == nil
			_ = BigUInt(truncating: -Decimal(10)) == nil
			_ = BigUInt(truncating: -Decimal(1000)) == nil
			_ = BigUInt(truncating: -Decimal(1000.1)) == nil
			_ = BigUInt(truncating: -Decimal(1000.9)) == nil
			_ = BigUInt(truncating: -Decimal(1001.5)) == nil
			_ = BigUInt(truncating: -Decimal(UInt.max) + 5) == nil
			_ = BigUInt(truncating: -(Decimal(UInt.max) + 5.5)) == nil
		}

		ChildBenchmark(label: "Decimal String Init", block: { i, label in
			BigUInt.initDecimalWithString = true
			bench(i, label)
		})

		ChildBenchmark(label: "Decimal Mantissa Init", block: { i, label in
			BigUInt.initDecimalWithString = false
			bench(i, label)
		})
	}
}
