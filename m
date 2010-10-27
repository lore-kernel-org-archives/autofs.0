From: Michael Orlov <orlovm@cs.bgu.ac.il>
Subject: autofs 5.0.4 and 5.0.5 do not remove ghost entries upon
	SIGHUP
Date: Wed, 27 Oct 2010 23:35:36 +0200
Message-ID: <20101027233536.5be72db1@cs.bgu.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Hi,

I think this is a bug - if it is not, I will be glad if someone
corrects me. I am using autofs on Gentoo.

In auto.master, put
  /mnt/test  /etc/auto.test  --ghost

In auto.test, put
  floppy -fstype=auto :/dev/fd0
(or anything similar)

1. start autofs
2. see that /mnt/test/floppy exists
3. remove / comment out the "floppy" line in auto.test
4. send SIGHUP to autofs

After these actions, in autofs 5.0.4 / 5.0.5 (but not
5.0.3), /mnt/test/floppy still exists - it is not removed after SIGHUP.

This is problematic, for example, when auto.test is maintained via
udev. Full restart of a service from a udev-invoked script is very
error-prone.

Thanks,
Michael
