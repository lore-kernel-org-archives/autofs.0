From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: automount 4.1.3 - strange behaviour in hearachy
Date: Tue, 22 Jun 2004 19:52:12 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3841B5@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Just testing autofs herarchies:

--- /etc/auto.master ---
/mnt/autofs     program:/etc/auto.autofs --timeout=50 --debug --verbose
------------------------

--- /etc/auto.autofs ---
#!/bin/bash

echo -fstype=autofs     program:/etc/auto.autofs
------------------------

cd /mnt/autofs/a/b/c
ps axww

--- output ---
...
23343 pts/0    S      0:00 /usr/sbin/automount --pid-file
/var/run/automount.mnt.autofs.pid --timeout=50 --verbose --debug
/mnt/autofs program /etc/auto.autofs
23385 pts/0    S      0:00 /usr/sbin/automount --submount --timeout=50
--debug /mnt/autofs/a program /etc/auto.autofs
23391 pts/0    S      0:00 /usr/sbin/automount --submount --timeout=50
--debug /mnt/autofs/a/b program /etc/auto.autofs
23397 pts/0    S      0:00 /usr/sbin/automount --submount --timeout=50
--debug /mnt/autofs/a/b/c program /etc/auto.autofs
...
--------------

a few seconds later automount with pid 23397 unexpectly dies
