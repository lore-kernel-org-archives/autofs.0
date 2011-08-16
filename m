From: "Denniston, Todd A CIV NAVSURFWARCENDIV Crane" <todd.denniston@navy.mil>
Subject: Re: autofs, closing file error.
Date: Tue, 16 Aug 2011 08:33:49 -0400
Message-ID: <DA1C49D1052ABF41939A2D8516F0C7E70658D479@naeacranez03v.nadsusea.nads.navy.mil>
References: <CABc702S9AtDk1nszh+=izXzZr8iV6FYN0TuA3AN7fYGCUnLgUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <CABc702S9AtDk1nszh+=izXzZr8iV6FYN0TuA3AN7fYGCUnLgUA@mail.gmail.com>
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
To: autofs@linux.kernel.org

> -----Original Message-----
> From: autofs-bounces@linux.kernel.org [mailto:autofs-
> bounces@linux.kernel.org] On Behalf Of wusheng zhang
> Sent: Saturday, August 13, 2011 9:04
> To: autofs@linux.kernel.org
> Subject: [autofs] autofs, closing file error.
> 
> Dear list:
> I am not sure, it is suitable posing the message  to this list. But
> this obsessed me for a long time.
> 
> 
> ####Problem description:
> I am running a fortran program, that doing some computation works and
> saves data to the
> working directory.
> I started the program at an automounted directory, here, in my
> situation, the directory is
> /work/zws_work/origin1.
> 
> when the program run, I got CLOSE error randomly.
> I also run the same copy of binary on a local disk, It never fail.
> 
> so I doubt is it the autofs problem?
> 
> But I have no idea how recognize and solve it,
> Switching to a newer version  of automount daemon may solve this
> problem?
<SNIP>
> #####[root@ln0 ~]# cat /etc/auto.work
> * -rw,soft,intr,proto=udp ibworkserver:/home/&
> 
<SNIP>

My experience says try changing the soft to hard.
i.e. 
* -rw,hard,intr,proto=udp ibworkserver:/home/&

hard,intr gives, in my opinion, a reasonable balance between the 'lock
the program up' of hard and 'give random unexplainable (an often silent)
errors when nfs drops a couple of packets' of soft.
I suggest also reading the soft entry in `man nfs`.
