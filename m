From: Ian Kent <raven@themaw.net>
Subject: Re: automounting replicated servers using NFSv4 fails
Date: Sat, 19 Feb 2011 11:48:06 +0800
Message-ID: <1298087286.2851.29.camel@perseus>
References: <1298034589.18517.52.camel@puppy.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=uzjLbt8piLplp6mrAaC/hzLPwsY=;
	b=pxiL0iSc/RezTUN+CJvW3qg99fetbE9x2jXp8HcJu2hHddIfsWjNgEac3y8hUp6qhzZVHWU4h1+Wau7lvFbag5e+pG37s89DHgEWNPf25iY64ZIMyhkdXUmGKYAvvrH4T3bPyqryLxniYUqQoS34aYqNZqZKDZVo6yFIbGTkHNA=
In-Reply-To: <1298034589.18517.52.camel@puppy.sonytel.be>
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
To: Nico De Ranter <nico.deranter@sonycom.com>
Cc: autofs@linux.kernel.org

On Fri, 2011-02-18 at 14:09 +0100, Nico De Ranter wrote:
> Hi,
> 
> I have a number of Linux clients (Ubuntu 10.04) that mount a (read-only)
> directory from 3 replicated servers using NFSv3.  I am now in the
> process of moving to NFSv4.  I can mount the directories using NFSv4
> manually. I can mount the directories using autofs over NFSv4 when I
> specify only 1 server (any of the 3 will work), but when I add all 3
> servers to the automount configuration file the mount fails.

Works OK for me, on Fedora 12.

> 
> The configuration files look as follows:
> 
> # /etc/automaster
> /-	/etc/auto.local
> 
> # /etc/auto.local
> /usr/local
> -fstype=nfs4,ro,nodev,nosuid,nonstrict,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8
> 192,soft  server1:/local/ubuntu64 server2:/local/ubuntu64
> server3:/local/ubuntu64
> 
> (Note: the content of /etc/auto.local is on 1 line but my e-mail
> application is splitting the content over multiple lines)
> 
> As I said above a similar setup using nfs in stead of nfs4 works fine,
> specifying only 1 server works fine too.
> 
> If I run automount manually with verbose and debugging enabled I see the
> following output when trying to access /usr/local:
> 
> #################################################
> handle_packet: type = 5
> handle_packet_missing_direct: token 296, name /usr/local, request pid
> 2887
> attempting to mount entry /usr/local
> lookup_mount: lookup(file): looking up /usr/local
> lookup_mount: lookup(file): /usr/local ->
> -fstype=nfs4,ro,nodev,nosuid,nonstrict,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8192,soft  server1:/local/ubuntu64 server2:/local/ubuntu64
> parse_mount: parse(sun): expanded entry:
> -fstype=nfs4,ro,nodev,nosuid,nonstrict,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8192,soft  server1:/local/ubuntu64 server2:/local/ubuntu64
> parse_mount: parse(sun): gathered options:
> fstype=nfs4,ro,nodev,nosuid,nonstrict,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8192,soft
> parse_mount: parse(sun): dequote("server1:/local/ubuntu64") ->
> server1:/local/ubuntu64
> parse_mount: parse(sun): dequote("server2:/local/ubuntu64") ->
> server2:/local/ubuntu64
> parse_mount: parse(sun): core of entry:
> options=fstype=nfs4,ro,nodev,nosuid,nonstrict,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8192,soft, loc=server1:/local/ubuntu64 server2:/local/ubuntu64
> sun_mount: parse(sun): mounting root /usr/local, mountpoint /usr/local,
> what server1:/local/ubuntu64 server2:/local/ubuntu64, fstype nfs4,
> options
> ro,nodev,nosuid,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8192,soft
> mount_mount: mount(nfs): root=/usr/local name=/usr/local
> what=server1:/local/ubuntu64 server2:/local/ubuntu64, fstype=nfs4,
> options=ro,nodev,nosuid,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8192,soft
> mount_mount: mount(nfs): nfs
> options="ro,nodev,nosuid,nodev,sync,_netdev,proto=tcp,retry=10,rsize=8192,wsize=8192,soft", nosymlink=0, ro=1
> get_nfs_info: called for host server2 proto tcp version 0x40
> get_nfs_info: called for host server1 proto tcp version 0x40
> mount(nfs): no hosts available
> dev_ioctl_send_fail: token = 296
> failed to mount /usr/local
> ####################################################
> 
> Any idea what might be going wrong?
> 
> Thanks in advance,
> 
> Nico
> 
