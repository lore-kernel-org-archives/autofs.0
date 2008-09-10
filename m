From: Ian Kent <raven@themaw.net>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Wed, 10 Sep 2008 11:49:46 +0800
Message-ID: <1221018586.3030.63.camel@raven.themaw.net>
References: <48C5F518.9010800@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48C5F518.9010800@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2008-09-09 at 14:01 +1000, Matthew Jurgens wrote:
> Hi
> 
> I recently upgraded to Fedora 9 and autofs-5.0.3-15.i386.
> I use SMB shares ending in $ quite often and have noticed that in this 
> release they are broken.
> They are mounting in the wrong place. Contrast the 2 shares  below, one 
> the C share, the other the C$ share. The wrong slash is in the remote 
> service name
> 
> Autofs mounted:
> //xp0/C on /smb/xp0/C type cifs (rw,mand)               <--- this one 
> workes ok
> //xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)          <----- this one is 
> broken
> 
> Manually mounted and working:
> //xp0/C$ on /mnt type cifs (rw,mand)

Can you post the output of the program map please.
That's probably "sh /etc/auto.smb <server name>".

Ian
