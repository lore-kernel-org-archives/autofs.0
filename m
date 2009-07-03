From: Ian Kent <raven@themaw.net>
Subject: Re: mount: mount point /home/user does not exist
Date: Fri, 03 Jul 2009 12:38:24 +0800
Message-ID: <4A4D8B40.9020402@themaw.net>
References: <4A4D3408.40103@idilia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A4D3408.40103@idilia.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Filipe Brandenburger <lists.filbranden@idilia.com>
Cc: autofs@linux.kernel.org

Filipe Brandenburger wrote:
> Hello,
> 
> I am using autofs-4.1.3-234 on a RHEL 4 machine, using kernel
> 2.6.9-78.0.1.ELsmp, getting automount maps from LDAP.
> 
> Recently I had failures in some hosts when mounting home directories, in
> some cases more than one host at a time.
> 
> I found this on the NFS client's log:
> 
>> Jun 30 16:51:21 clnt automount[9458]: >> mount: mount point /home/user
>> does not exist
>> Jun 30 16:51:21 clnt automount[9458]: mount(nfs): nfs: mount failure
>> srvr:/export/home/user on /home/user
>> Jun 30 16:51:21 clnt automount[9458]: failed to mount /home/user
> 
> But on the NFS server, this is all I see:
> 
>> Jun 30 16:51:21 srvr rpc.mountd: authenticated mount request from
>> clnt.example.com:731 for /export/home/user (/export/home) 

This does sound a bit like a known problem.
A bunch of patches have gone into RHEL-4 U8 which resolved almost all
reported problems. You will need to log a bug or update to U8 to check.

Ian
