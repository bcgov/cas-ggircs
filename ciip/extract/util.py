
def zero_if_not_number(a):
    try:
        return float(a)
    except:
        return 0

def none_if_not_number(a):
    try:
        return float(a)
    except:
        return None

def partial_dict_eq(a, b, fields):
    for f in fields:
        if a.get(f) != b.get(f):
            return False
    return True

## using the provided function, returns an array where the equal dicts are merged
def reduce_dicts_array(dicts_array, should_merge_fn):
    if len(dicts_array) == 1:
        return dicts_array

    for i in range(len(dicts_array) - 1):
        if (should_merge_fn(dicts_array[i], dicts_array[i+1])):
            reduced_array = dicts_array[0:i] if i > 0 else []
            reduced_array.append({**dicts_array[i], **dicts_array[i+1]})
            reduced_array += dicts_array[i+2:len(dicts_array)]
            return reduce_dicts_array(reduced_array, should_merge_fn)

    return dicts_array


def get_sheet_value(sheet, row, col, default = None) :
    v = sheet.cell_value(row, col)
    return v if (v != '' and v != 'N/A') else default

def search_row_index(sheet, col, value):
    for r in range(sheet.nrows):
        if (get_sheet_value(sheet, r, col) == value):
            return r
    return -1

def search_col_index(sheet, row, value):
    for c in range(sheet.ncols):
        if (get_sheet_value(sheet, row, c) == value):
            return c
    return -1