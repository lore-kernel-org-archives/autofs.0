From: "Mike Matera" <spamme@fatboycentral.com>
Subject: Allow period in -Dvariable=value flags in auto.master
Date: Thu, 19 Apr 2007 13:55:21 -0700
Message-ID: <40ddc4e40704191355w360b3e3bj6fa6615d6c3defa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi,

In order to use autofs on my company network I must override OSNAME,
ARCH and OSREL to match other Linux boxes.  Previous automount allowed
the following line in auto.master:

/stuff yp:auto.stuff -DOSNAME=Linux -DARCH=i686 -DOSREL=2.4

This stopped working on my FC6 box (autofs-5.0.1-0.rc3.10) because the
parser choked on the '.' in 2.4.  I couldn't find anyone else who'd
run into this problem so I made a patch to master_tok.l that allows
periods in the variable values.

All I did was add '\.' to the character class on the right side of the
equal sign in the MACROSTR rule.  The code is shown below:

MACROSTR (-D{OPTWS}([[:alpha:]_]([[:alnum:]_\-])*)=([[:alnum:]_\-\.])+)

Cheers
./m
