import os


force_install = False

cur_abs_path = os.path.abspath(".")

home_abs_path = os.path.expandvars("$HOME")


class item(object):

    def __init__(
        self, name=None, files=None, depence=None,
        after_install_msg=None
    ):
        self.name = name     # name of this item
        self.files = files   # tuple
        self.depence = depence  # depence items tuple
        self.installed = False  # if has been installed
        self.after_install_msg = None

    def install(self):       # install method
        pass

    # ln -s files to home
    def lns_to_home(self):
        for path in self.files:
            src_abs = os.path.join(cur_abs_path, path)
            des_abs = os.path.join(home_abs_path, path)
            des_dir = os.path.dirname(des_abs)
            if not os.path.exists(des_dir):
                os.makedirs(des_dir)
            rm_if_exists(des_abs)
            print color('green', "Symbol link:" + path + " -> " + des_abs)
            os.symlink(src_abs, des_abs)


# funtions for install ....

# color output
def color(clr, msg):
    colors = {
        'red': '\033[91m',
        'green': '\033[92m',
        'yellow': '\033[93m',
        'blue': '\033[94m',
        'tail': '\033[0m'
    }
    return colors[clr] + msg + colors['tail']


def rm_if_exists(path):
    if os.path.exists(path):
        x = ''
        if force_install:
            x = 'yes'
        while x != 'yes' and x != 'no':
            x = raw_input(
                color(
                    'red',
                    "Path " + path +
                    " already exists, remove? (yes/no)"
                )
            )

        if x == 'yes':
            print color('yellow', 'Remove ' + path + ' ...')
            try:
                os.remove(path)
            except:
                try:
                    import shutil
                    shutil.rmtree(path)
                except Exception, e:
                    raise e
        else:
            exit(color('red', 'Abort.'))
