From: Andrew Klaassen <clawsoon@yahoo.com>
Subject: Indirect multi-mount map sometimes needs client reboot
	after update
Date: Fri, 21 May 2010 13:12:34 -0700 (PDT)
Message-ID: <510030.76217.qm@web65411.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1274472754; bh=p31Liv9vHVK+oqhs78sJcpLxnznBJ5FkDWteEXRa+oU=;
	h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
	b=HlkWvQV1wejkMpDCk+gSSmOFeSs1WBLkjiqk6admZMXHJl8SoxgT9ULuWj7NQtpFyiq4pADI5dE1X7OW9pR2Y9sGQNBAau4vypS2yZCtxOspxk+aQH+te9sAnfNOjCDe4nP+YXDGlXMdHbCO4V2DWJvA/cRx2y72DlguCtk43eE=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

I've got indirect multi-mount and single-mount maps set up in NIS like so:

auto.master:

/test auto.test --ghost

auto.test:

foo /    -tcp,intr server1:/foo \
    /bar -tcp,intr server2:/bar
abc      -tcp,intr server1:/abc

Changes to single-mount maps are picked up immediately by clients.

Changes to multi-mount maps are picked up:

1. Immediately if nothing under the key is currently mounted.

2. Only after an autofs restart - or sometimes even a reboot - after anything has been mounted under the key.

Is it possible to make #2 go away?  Having to reboot every single one of hundreds of client machines after a single change is a downer.

I'm running Centos 5.2 to 5.4 with autofs-5.0.1-0.rc2.88 to autofs-5.0.1-0.rc2.143.

Thanks.

Andrew
