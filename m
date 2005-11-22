From: Farkas Levente <lfarkas@bppiac.hu>
Subject: Re: automount never umount
Date: Tue, 22 Nov 2005 17:19:03 +0100
Message-ID: <438344F7.8020503@bppiac.hu>
References: <4381E865.4070908@bppiac.hu>
	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
	<4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> That wasn't what I had in mind.
> 
> I was thinking more along the lines of the definition of what constitues 
> "use". For example any access, such as a directory listing, will update 
> the "last used" value whereas if I change the definition of "last used" to 
> "currently in use" then to be busy there would have to be an open file or 
> a process working directory set. This may solve the GUI scanning problem 
> we see but wouldn't solve immediate remounting that occurs due to the 
> scanning as well.

that would be useful and may be solve our problem. without it the
current implementation is not usable to umount. think about just the
daily process like slocate database update, tripwire and may be others.

-- 
  Levente                               "Si vis pacem para bellum!"
