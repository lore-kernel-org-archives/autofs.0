From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: Fedora 8 And Autofs
Date: Thu, 14 Aug 2008 16:21:27 -0400
Message-ID: <48A493C7.7030305@ssa.crane.navy.mil>
References: <66342.23825.qm@web54301.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <66342.23825.qm@web54301.mail.re2.yahoo.com>
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
Cc: autofs@linux.kernel.org

Thanh Tran wrote, On 08/14/2008 12:07 PM:
>> And where is the auto.master, that you believe should be
>> used, located?
> 
> It's in /etc/auto.master
> 
> I'm expecting my cdrom to mount to /mnt/cdrom.  I have the same rules for other drives.  When mounted, the cdrom would be on /mnt/cdrom/cdrom.  Kind of strange naming but should still work.
> 
> My /etc/nsswitch.conf file contains the following.  I removed the comments.
> 
<SNIP>
> 
> Everything else was commented out.  
> 
> Thanks for all the help.  I'm still working on the jmoyer thing.  Maybe, I'll see something there.
> 
> 

extra question/observation/suggestion:
Do you have SELinux installed on your box, and in enforcing mode?

I have been seeing messages on the fedora list indicating that SELinux is a 
lot more anal now about 'tags' on files, and if you copied the auto.master (or 
any of the others) instead of editing them in place, then they now have the 
wrong 'tag'.  Not sure if the extra anal SEL came in F8 or F9.

while running `tail -f /var/log/messages` issue `service autofs restart`, and 
see if you get any SELinux messages.  If you do, then we have to remember the 
incantation to get the 'tag's back to right.

-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane)
Harnessing the Power of Technology for the Warfighter
