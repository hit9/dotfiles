"""
Usage:
  setup.py <item>... [--force]
"""


if __name__ == '__main__':

    from docopt import docopt
    import item
    from item import color

    argvs = docopt(__doc__)
    item.force_install = argvs['--force']
    items_to_install = argvs['<item>']

    import conf

    items = dict(
        (k.name, k) for k in conf.__dict__.values() if isinstance(k, item.item)
    )
    
    for i in items_to_install:
        if i not in items:
            exit(color("red", "Unknown item: "+i))
        v = items[i]
        # install depence
        if v.depence:
            for d in v.depence:
                d.install()
                d.installed = True

        # install this item
        v.install()
        v.installed = True

    # after messages..
    for i in items_to_install:
        k = items[i]
        if k.after_install_msg:
            print color("green", str(k.after_install_msg))
