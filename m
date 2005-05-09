From: Jeremy Rosengren <jeremy@rosengren.org>
Subject: autofs 4.1.4 regression?
Date: Mon, 09 May 2005 16:30:07 -0500
Message-ID: <427FD65F.2050708@rosengren.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

I previously worked with Ian to troubleshoot and resolve some problems 
that I was seeing with autofs 4.1.3's replicated server code.  
Everything had been working swimmingly with Fedora Core 3's autofs 
4.1.3-114 package.

I'm testing Fedora Core 4, and am seeing problems with replicated host 
maps and autofs 4.1.4-5.

Here's the map:

[root@flexer ~]# ypcat -k auto_group
icdes ausfiler,minnfiler2:/vol/vol0/data/group/&

Here's what happens:

[root@flexer ~]# cd /group/icdes
-bash: cd: /group/icdes: No such file or directory

Here's what /var/log/messages says:
May  9 16:25:48 flexer automount[8202]: mount(nfs): host 
ausfiler,minnfiler2: lookup failure
May  9 16:25:48 flexer automount[8202]: >> mount: special device 
/vol/vol0/data/group/icdes does not exist
May  9 16:25:48 flexer automount[8202]: failed to mount /group/icdes

Using 4.1.3-114 in FC3 this works without any problems.  Also, 
non-replicated maps seem to be working just fine.  Any other information 
I can gather to help troubleshoot?

Thanks,

-- jeremy
