From: Dominique Le Foll <dominique@le-foll.demon.co.uk>
Subject: Silent bug in autofs when conf file are in dos format
Date: Sun, 28 Mar 2004 22:56:48 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40673C10.901@le-foll.demon.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hello,

after importing /etc/auto.*  from one linux server to an other via a 
VFAT drive I have noticed that if the configuration files for atofs  are 
in DOS format, autofs does not complain but fail to mount.

As vi is silent on DOS text format it's not that easy to detect why it 
does not work.

A warning indicating Martian char (0x0D) in the file would do the job, a 
silent proper management as well.

I use Linux Suse 9.0 (kernel 2.4.21).

Regards

Dominique
