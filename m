From: Amuraritei Andrei <sirdeiu@Bydeiu.net>
Subject: Mount point permission
Date: Wed, 03 Sep 2014 21:57:04 +0300
Message-ID: <1409770624.8847.7.camel@deiu.bydeiu.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

Hello, 

I'm using autofs 5.0.7 on Fedora 20 and have a question regarding the
mount point permissions.

Specifically if autofs creates a direct or indirect mount point, for
example /share (which holds the storage nfs exported folder), I can't
seem to create another folder in /share.

So mkdir /share/storage/dir1 works. But mkdir /share/dir1 doesn't. I
guess it's by design(?) but couldn't find anything specific about this.

Permissions are root:root 0755 for /share from filesystem. But when
trying mkdir /share/dir (while it's mounted by autofs),  and as root, I
get permission denied.

Is this because of autofs needing to unmount /share when not used (with
timeout) or is it just some bug ?

Thanks.

Andrei Amuraritei

