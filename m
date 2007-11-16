From: Ian Kent <raven@themaw.net>
Subject: Re: parse(sun): invalid location
Date: Fri, 16 Nov 2007 15:04:39 +0900
Message-ID: <1195193079.3131.18.camel@raven.themaw.net>
References: <651920.10654.qm@web35502.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <651920.10654.qm@web35502.mail.mud.yahoo.com>
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
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-11-15 at 21:10 -0800, Sandra Bonus wrote:
> Reproduce the problem using 
> 
> ls -l /smb/awmelfp01/awmelsales1_backupsOther debug info attached

I think the script has an error in it.

From the debug log I can see the bit that causes the problem is:

/TS\ SSP National "://awmelfp01/TS\ SSP National"

where the second space isn't being quoted.

Can you also post the auto.samba that you are using (whether it's just
the default or not) so I can check it out please.

Ian
