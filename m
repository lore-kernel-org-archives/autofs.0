From: Ian Kent <raven@themaw.net>
Subject: Re: automounter works for some maps, fails on another
Date: Sat, 15 Oct 2005 19:06:49 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0510151904030.2102@donald.themaw.net>
References: <56eb9cd10510061043t1ec2b762kab81d85c42fe12e1@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <56eb9cd10510061043t1ec2b762kab81d85c42fe12e1@mail.gmail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bill Geddes <wkgeddes@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 6 Oct 2005, Bill Geddes wrote:

> I have a puzzling problem. When I start the autofs
> service on a client, the local /var/log/messages file shows:
> 
> Sep 29 13:41:34 clonehost2 autofs: automount startup succeeded Sep 29
> 13:41:34 clonehost2 automount[10732]: failed to load map, exiting
> 
> - automount processes are all running, but
> On the server side, I get ' rpc.mountd: getfh failed: Operation not
> permitted'.
> 
> Here's the output of `ypcat -k auto.master`
> /server/homes server.homes
> /server/File_Access auto.file_access
> /auto/data auto.data
> /auto/bitsrus auto.bitsrus
> /nfs auto.hosts
> 
> ** The automounter manages to mount these maps just fine!
> 
> and `ypcat -k server.homes`
> svr_homes -rw,intr,rsize=8192,wsize=8192,timeo=14 svr:/vol3/server_homes
> 
> ** This is the one that fails.
> Manually mounting this fails as well.

If you can't mount it manually with mount you don't need to try autofs.
You need to sort that out first.

Try the NFS list.

I'm not aware of problems with 64 bit clients.

Ian
