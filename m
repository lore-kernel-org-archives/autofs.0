From: "Gomez, Daniel" <dgomez@tigr.org>
Subject: RE: Issuing custom mount commands within an autofs
	controlled mountpoint
Date: Fri, 23 Jun 2006 11:36:09 -0400
Message-ID: <7F0AA25C9B1706448E8B73DFDD109B31028E5AD6@EXCHANGE.TIGR.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Thank you Ian for the thoughts.

I did try to hijack the /bin/mount command with a simple wrapper but it
doesn't work potentially due to the fact that this custom mount command
(ibrix_lwmount) is not returning the correct information back to the
automount command, either in terms of return code, time delay (which the
ibrix command does take some time), and/or verbose stdout which it has
lot of that as well which the automount may not like. 

I have yet delved further into which if any of these may be why the
automount is balking, but I'll let you know when I do along with the
code and results.

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Tuesday, June 20, 2006 11:06 PM
To: Gomez, Daniel
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Issuing custom mount commands within an autofs
controlled mountpoint


On Tue, 20 Jun 2006, Gomez, Daniel wrote:

> Hello,
>  
> Is it feasible to hijack the automounter and issue your own custom 
> mount command or must the automount program perform the actual "mount"

> call?

The path to "mount" is established at compile time.
Not being able to hijack mount is probably considered good seurity 
practice.

You would need to write a warpper around mount to check the filesystem 
given in the -t and issue the mount command of your choice or call the 
normal mount.

I guess it would be possible to add a configure option to allow an 
alternate commands to be used for all mounting and umounting. That would

take a bit of work though as the existing configure setup isn't designed

allow for this.

>  
> The reason why I am interested is that we are using the IBRIX parallel

> filesystem and we wish to have some clients mount IBRIX exported 
> shares using it's own special "ibrix_lwmount" client mount command and

> non-ibrix clients to use the normal automount process. The catch is we

> want to use the same mountpoint under the control of autofs for both 
> ibrix and non-ibrix clients.
>  
> Is this feat feasible? Any insight into how one might even approach 
> this problem would be helpful to me and maybe to the whole community 
> of ibrix users using linux.
>  
> I will say, I was able to simply double mount seemingly ok, meaning I 
> allow the automount to mount the directory as it will under normal 
> circumstances for regular clients, but then I run the ibrix mount 
> command ontop of the same directory. At first I was also using the 
> special ibrix umount command before I stopped the autofs daemon, but 
> it seems if I don't umount the double mounted directory, autofs still 
> unmounts all directory keys under the parent mountpoint fine.

Yep. You can stack mount points in 2.6.

The only real requirement for autofs to be able to expire mounts is that

they appear in /etc/mtab.
