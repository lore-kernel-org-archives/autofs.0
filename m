From: "Rigler, Steve" <SRigler@MarathonOil.com>
Subject: RE: making the mountpoints visible all the time
Date: Fri, 14 Nov 2003 15:34:39 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE712618FD@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org


> -----Original Message-----
> From: autofs-bounces@linux.kernel.org
> [mailto:autofs-bounces@linux.kernel.org]On Behalf Of 
> Alexander Macdonald
> Sent: Friday, November 14, 2003 2:20 PM
> To: autofs@linux.kernel.org
> Subject: Re: [autofs] making the mountpoints visible all the time
> 
> 
> I'm using kernel 2.6.0-test9, i could only see patches for 2.4 so i 
> guess this has the latest autofs in it allready right? I've also 
> upgraded my daemon to autofs-4.1.0-beta3. I then tried running this:-
> 
> automount -g /mnt/network/samba/computerA file /etc/autofs/samba
> 
> in the file /etc/autofs/samba I have this:-
> 
> download    -fstype=smbfs,username=guest,password=none 
> ://computera/Download
> upload        -fstype=smbfs,username=guest,rw,password=none 
> ://computera/Upload
> 
> it works fine but it still doesnt do the "ghosting"
> 
> 

I haven't tried the 2.6 kernel yet, so anything I suggest would be
based on experience with the 2.4 kernel.

One thing is to make sure you have an entry in /etc/modules.conf
to force loading of the autofs4 module.

It should look like:
alias autofs autofs4

If you have to add the line then stop autofs.  Do "rmmod autofs"
and then start autofs again (I believe the init script will load
the module for you).

-Steve
