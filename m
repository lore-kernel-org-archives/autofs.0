From: "Kfir Lavi" <lavi.kfir@gmail.com>
Subject: White spaces in mount point
Date: Tue, 26 Sep 2006 16:03:38 +0300
Message-ID: <b688507b0609260603o4c94a308ke3bc394966fdbc53@mail.gmail.com>
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
I have this problem:
When I try to mount samba share with white spaces, I get an error:
Sep 26 15:40:20 [automount] failed to mount /tmp/explorer/test1/AAA_My Pictures

My auto.aaa file:
"AAA_My Pictures" -fstype=smbfs,ro :"//AAA/My Pictures"

Tried without the quotes:
AAA_My Pictures -fstype=smbfs,ro ://AAA/My Pictures

How can I mount share names that have white spaces?

Tnx,
Kfir
