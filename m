From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: "simultaneous" mounts causing weird behavior
Date: Wed, 5 Nov 2003 12:45:17 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6B9D@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, Matthew Mitchell <matthew@geodev.com>
Cc: autofs@linux.kernel.org



-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Ian Kent
Sent: Tuesday, November 04, 2003 6:47 PM
To: Matthew Mitchell
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] "simultaneous" mounts causing weird behavior

> 
> The /tmp entry is caused by mount failing to handle overlapping
requests.
> Aaron Ogden and I have been there recently with autofs v4.
> 
> The overlapping mount problem is likely causing the other problem as
well.
> I put some altogether ugly code, which shouldn't work at all, but
seems
> to, into autofs v4 to deal with this. In fact I hated it so much, I
> removed it at one point and Aaron was horrified to find everything
broken
> again.
> 
> Also, since the bind mount was only a test I added the -n flag to it
to
> get rid of the /tmp mount entries. Maybe Peter would like to try
something
> like that in autofs v3.

Ugly or not, autofs 4.1.0 beta2 is working pretty well over here.  :-)
Once the hung mountpoint problem gets resolved I will be a happy camper.
Ian, any word on when autofs 4.1.0 final might be released?

Re: /tmp mount entries, I found it to be a good indicator of problems
with autofs (overlapping mounts, etc.) so it was actually useful in a
way.

-A
