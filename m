From: Ondrej Valousek <webserv@s3group.cz>
Subject: How to pass "-n" option to the mount command via
	automounter?
Date: Wed, 30 Jul 2008 11:57:54 +0200
Message-ID: <48903B22.3000608@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi List,

I am wondering - I have diskless systems deployed here with /etc being
read-only -> I need to pass "-n" option to the mount command in order to
make it working.
I tried:
> automount -O "-n"
but it passes the -n option after -o, like this:

mount_mount: mount(nfs): calling mount -t nfs -s -o -n
hercules:/ext3/tmp /proj/tmp

I need the -n option to be passed before "-o". How could I do it?
Many thanks for your help.

Ondrej
