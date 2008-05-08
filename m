From: Ian Kent <raven@themaw.net>
Subject: Re: How to change the FSINFO for nfsd?
Date: Thu, 08 May 2008 14:24:53 +0800
Message-ID: <1210227894.1392.54.camel@raven.themaw.net>
References: <4821BEAC.4070802@singnet.com.sg>
	<x49skwunmju.fsf@dhcp-100-18-209.bos.redhat.com>
	<48224E12.8010109@singnet.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48224E12.8010109@singnet.com.sg>
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
To: "P.V.Anthony" <pvantony@singnet.com.sg>
Cc: autofs@linux.kernel.org


On Thu, 2008-05-08 at 08:49 +0800, P.V.Anthony wrote:
> Jeff Moyer wrote:
> 
> > You're really stabbing in the dark, here.  I suggest you email the
> > software manufacturer of Final Cut Pro (Apple?) with a support request.
> 
> You are right but Apple is not going to help because I am using Linux.
> They would ask me to buy a Apple Xserve.
> 
> I know it will work because the commercial company made the changes and
> it works. I also understand that they will not share the code change
> because it is a commercial thing.
> 
> Here is their email. At least they are willing to share this.
> -------------- start ----------------------
> 
> Yes we arrive to an interesting conclusion. Over NFS the Max OSX10.5
> client uses the NFS FSINFO request to discover NFS server capabilities
> such as the max file size. Specifically Mac NFS servers return a value
> of all '1's for the max file size field in the FSINFO response. This
> value is not realistic but tell the Mac client that this is a Mac NFS
> server that can handle files larger then 2GB.
> 
> We are a storage vendor so we changed the code for our NFS server to
> return the same FSINFO information and that resolved the file chopping
> problem. It also fixed another bug where copies over the finder of files
> over 4GB failed. Now they don't.
> 
> -------------- end   ----------------------
> 
> If possible, please share how to change the code to make the FSINFO
> present all '1's for the max file size field.

This isn't the place to ask how to make changes to the kernel NFS
client. You should probably ask this on the linux-nfs list.

Ian
