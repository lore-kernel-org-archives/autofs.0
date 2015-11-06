From: Greg Earle <earle@isolar.DynDNS.ORG>
Subject: "rmdir_path: lstat of <path> failed" issues, despite updated autofs RPM
Date: Fri, 6 Nov 2015 13:03:23 -0800
Message-ID: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG>
Reply-To: autofs@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

Ian et al.:

We just upgraded a production server from RHEL 5.4 to 5.10.  (Yeah, yeah, I
know - I work at a place that has things called "flight project freezes".)

Ever since then, we keep getting these mysterious autofs messages:

[root@mipldiv log]# grep rmdir_path messages | wc -l
100

[root@mipldiv log]# grep rmdir_path messages | tail -5
Nov  6 08:30:05 mipldiv automount[31419]: rmdir_path: lstat of /home/objects failed
Nov  6 09:30:05 mipldiv automount[31419]: rmdir_path: lstat of /home/objects failed
Nov  6 11:30:05 mipldiv automount[31419]: rmdir_path: lstat of /home/refs failed
Nov  6 11:45:05 mipldiv automount[31419]: rmdir_path: lstat of /home/objects failed
Nov  6 12:30:05 mipldiv automount[31419]: rmdir_path: lstat of /home/refs failed

[root@mipldiv log]# ypcat -k auto.home | grep objects
[root@mipldiv log]# ypcat -k auto.home | grep refs
[root@mipldiv log]# 

(I have no idea where these "/home/objects" or "/home/refs" paths come from;
we do not have any accounts with those names, obviously.)

We're running the latest RHEL 5.x autofs version as far as I can tell:

[root@mipldiv log]# rpm -qa autofs*
autofs-5.0.1-0.rc2.184.el5

I have this problem on several machines; including - bizarrely enough -
3 machines on one flight project that get a rash of them all at exactly
the same time (usually 8:45 PM).  Those systems are currently frozen but
may also be upgraded to 5.10 soon.

Bug 336961 implies that this was addressed in an Errata (RHBA-2008-0354),
but we are a full superseded Errata revision (RHBA-2014:1240-2) beyond that
one already, and yet I'm still seeing these messages.

https://bugzilla.redhat.com/show_bug.cgi?id=336961

Given the age of RHEL 5.x am I better off trying to track down the cause
of these phantom "/home" paths so the messages won't come out at all?
Because I really don't have a clue where these "objects" & "refs" references
are coming from.

	- Greg

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
