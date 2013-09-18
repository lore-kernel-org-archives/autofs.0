From: Tim Landscheidt <tim@tim-landscheidt.de>
Subject: How to specify "helper=x" option?
Date: Wed, 18 Sep 2013 01:41:12 +0000
Message-ID: <8761tyx5xj.fsf@passepartout.tim-landscheidt.de>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hi,

on Fedora 19 with autofs 5.0.7-28, I want to set up auto-
matic mounting and unmounting of encrypted removable devices
with the basic idea: The program used as a map unlocks the
device to /dev/mapper/a and then makes autofs mount the lat-
ter with "helper=x", so that when unmounting, my script
/sbin/umount.x is called that unmounts the file system and
locks the device again.

However, with a (for testing static) map of:

| test   -fstype=ext4,helper=test,ro   :/dev/vg_passepartout/test

the helper option doesn't survive:

| /dev/mapper/vg_passepartout-test on /mnt/test type ext4 (ro,relatime,seclabel,data=ordered)

The "ro" shows that the options aren't ignored altogether.

Mounting manually ("mount -o helper=test
/dev/vg_passepartout/test t") works:

| /dev/mapper/vg_passepartout-test on /root/t type ext4 (rw,relatime,seclabel,data=ordered,helper=test)

Are the options to mount filtered by autofs?  Are there
other hooks that are called on autofs unmounts and could be
used for that purpose?

TIA,
Tim

