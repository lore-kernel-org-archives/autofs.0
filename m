From: Greg Bradner <gregb@rhythm.com>
Subject: expired program mounts
Date: Wed, 22 Oct 2003 06:11:43 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F96820F.6030406@rhythm.com>
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

Is there a way to get expired program mounts to umount?

In auto_master:
/nfs/hosts3   /etc/auto_maps/autofs_host_mount.pl vers=3,mountvers=2

In /var/log/messages:
Oct 22 06:07:51 lid2 automount[2693]: expired /nfs/hosts3/lid0

When I run a df:
lid0:/local/a         71370008  28701972  39042572  43% 
/nfs/hosts3/lid0/local/a

The mount has not been used in weeks. This is a big problem since 
machines hang if the the mounted host goes down.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                           Rhythm & Hues
              5404 Jandy Place, Los Angeles, CA 90066
    gregb@rhythm.com, Voice: 310 448-7763, Fax: 310 448-7600
