//
//  SudokuClassifier_1Input+Init.swift
//  Cyberdoku
//
//  Created by Nick Hart on 6/26/25.
//

import Foundation

// TODO: this is seriously uggo and not maintainable/extendable--need to figure out why MLMultiArray wouldn't work

extension SudokuClassifier_1Input {
    convenience init(from board: [Int]) throws {
        precondition(board.count == 81, "Board must have exactly 81 cells")
        self.init(
            cell_0: Int64(board[0]), cell_1: Int64(board[1]), cell_2: Int64(board[2]), cell_3: Int64(board[3]), cell_4: Int64(board[4]),
            cell_5: Int64(board[5]), cell_6: Int64(board[6]), cell_7: Int64(board[7]), cell_8: Int64(board[8]), cell_9: Int64(board[9]),
            cell_10: Int64(board[10]), cell_11: Int64(board[11]), cell_12: Int64(board[12]), cell_13: Int64(board[13]), cell_14: Int64(board[14]),
            cell_15: Int64(board[15]), cell_16: Int64(board[16]), cell_17: Int64(board[17]), cell_18: Int64(board[18]), cell_19: Int64(board[19]),
            cell_20: Int64(board[20]), cell_21: Int64(board[21]), cell_22: Int64(board[22]), cell_23: Int64(board[23]), cell_24: Int64(board[24]),
            cell_25: Int64(board[25]), cell_26: Int64(board[26]), cell_27: Int64(board[27]), cell_28: Int64(board[28]), cell_29: Int64(board[29]),
            cell_30: Int64(board[30]), cell_31: Int64(board[31]), cell_32: Int64(board[32]), cell_33: Int64(board[33]), cell_34: Int64(board[34]),
            cell_35: Int64(board[35]), cell_36: Int64(board[36]), cell_37: Int64(board[37]), cell_38: Int64(board[38]), cell_39: Int64(board[39]),
            cell_40: Int64(board[40]), cell_41: Int64(board[41]), cell_42: Int64(board[42]), cell_43: Int64(board[43]), cell_44: Int64(board[44]),
            cell_45: Int64(board[45]), cell_46: Int64(board[46]), cell_47: Int64(board[47]), cell_48: Int64(board[48]), cell_49: Int64(board[49]),
            cell_50: Int64(board[50]), cell_51: Int64(board[51]), cell_52: Int64(board[52]), cell_53: Int64(board[53]), cell_54: Int64(board[54]),
            cell_55: Int64(board[55]), cell_56: Int64(board[56]), cell_57: Int64(board[57]), cell_58: Int64(board[58]), cell_59: Int64(board[59]),
            cell_60: Int64(board[60]), cell_61: Int64(board[61]), cell_62: Int64(board[62]), cell_63: Int64(board[63]), cell_64: Int64(board[64]),
            cell_65: Int64(board[65]), cell_66: Int64(board[66]), cell_67: Int64(board[67]), cell_68: Int64(board[68]), cell_69: Int64(board[69]),
            cell_70: Int64(board[70]), cell_71: Int64(board[71]), cell_72: Int64(board[72]), cell_73: Int64(board[73]), cell_74: Int64(board[74]),
            cell_75: Int64(board[75]), cell_76: Int64(board[76]), cell_77: Int64(board[77]), cell_78: Int64(board[78]), cell_79: Int64(board[79]),
            cell_80: Int64(board[80])
        )
    }
}
