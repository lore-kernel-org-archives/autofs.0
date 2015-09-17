From: Dan Fitch <danielfitch@gmail.com>
Subject: Autofs Question
Date: Thu, 17 Sep 2015 10:14:43 -0500
Message-ID: <CAM2qnR73c7j5yFa+b2AA7zArFH9uODYGx9egW_ijthdisXRLQw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=L7Y1oKsxtslmDWx40YOiD6usNHMHGQ/YZ++2vWfKsto=;
        b=ymPjXzVeldGOkNY7FXZVy0Swtgl0fynLyzAp986zXb/ym98NO8BX2ylRdlEHpYRdfu
         RCou7oCCcbzNcSubOuLZC02Tz8IBEBLPto6UeQ3zd6QbTf89GcF2WkwG5T+nDIUV16H/
         kPw63Ce6TB80ZMIRDUWaBCflHKsfXL+fgqC7ozExg/B4quDpnnWkTUyg5EPMH8W8KFcL
         QN5SL29Z7zGYsIVS5OqaFVMDHC2aLjzZ1VOV1QgMMK2ISApcFUtwaHyH/ABKhmQDuKaN
         MYhvWgcFqHfFdaB033sldEx8M1ROnHijhPxH+yt3Z9v0SYtESCOykNVgamUjnVxn6c6X
         /wBg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

I was wondering if anyone could try to point me in the right direction
with this error that happens when reloading autofs.

We have thousands of users and we populate the /etc/auto.master file
with those users automounts that are currently logged into this
server.

/-   /path_to/automounts/user1/auto.user1_mounts --timeout=600
/-   /path_to/automounts/user2/auto.user2_mounts --timeout=600

Here is the typical scenario.
User logs in and  /etc/auto.master is populated with their automounts.
/etc/init.d/autofs reload is run and output to /var/log/syslog
contains the following message.

Sep 15 13:23:11 server automount: do_umount_autofs_direct: couldn't
get ioctl fd for direct mount
/path_to_a_mount_within_users_automount_file.

The " couldn't get ioctl fd for direct mount" message will repeat on
every reload.

The automaster files are in the following format.

/path_to_mount -rw,fstype=fuse,allow_other,port=PORT#
:sshfs\#remote_user@IP\:/remote_path

These are fuse mounts that are possibly within another datacenter.

Version

5.1.1

Compile options:

  LIBXML2_WORKAROUND

Ubuntu 14.04

Let me know if I can add any details and I will.

Thank you,

Dan
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
