From: Tom Georgoulias <tom.georgoulias@motorola.com>
Subject: Re: newly added heirarchical mount points not found
Date: Wed, 25 Feb 2004 08:18:35 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <403CAEBB.6010003@motorola.com>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com>
	<1077211301.19371.34.camel@brilong-lnx2.cisco.com>
	<Pine.LNX.4.58.0402202058120.4573@raven.themaw.net>
	<1077284694.21595.54.camel@brilong-lnx2.cisco.com>
	<Pine.LNX.4.58.0402211534050.4697@raven.themaw.net>
	<403AA2A7.3010409@motorola.com>
	<Pine.LNX.4.58.0402251203060.31545@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402251203060.31545@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Thank you for your help on this.

Ian Kent wrote:

> Browsable mount points are a must. 

For this to work?  Or just to get all the benefits of autofs4?

> Anyway try the HUP signal.

I wasn't successful.  On a Red Hat Linux 8.0 system using autofs-4.1.0-2 
and the autofs4-20031201 kernel module:

1. Made a test mount entry and pushed out the change

hatfield3:tomg$ ypmatch -k sync_caches auto.design
sync_caches <snip>
/tomg_test -suid bender:/export/bender/tomg/tmp/tomg_test
<snip>

2. Tried to access it on Linux
hatfield3:tomg$ cd /design/sync_caches/tomg_test
-bash: cd: /design/sync_caches/tomg_test: No such file or directory

3. Tried to access it on Solaris
fry:tomg$ cd /design/sync_caches/tomg_test
fry:tomg_test$

4. Sent HUP signal to automount daemon on Linux
[root@hatfield3 root]# psg design
root      1274     1  0 08:00 ?        00:00:00 /usr/sbin/automount 
/design yp a
[root@hatfield3 root]# kill -1 1274

5. Try again on Linux:
hatfield3:tomg$ cd /design/sync_caches/tomg_test
-bash: cd: /design/sync_caches/tomg_test: No such file or directory

Did I overlook something, or do it incorrectly?
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Motorola Internal Use
[] Motorola Confidential Proprietary
