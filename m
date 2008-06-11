From: Max Harvest <max_h@limbus.net>
Subject: Re: automount ignores remote logins
Date: Wed, 11 Jun 2008 17:55:24 +0200
Message-ID: <20080611175524.aytzfqk80ksgowkc@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

On Wed, Jun 11, 2008 at 4:09 PM, Jeff Moyer <jmoyer@redhat.com> wrote:
> "Max Harvest" <rootserver94@googlemail.com> writes:
>
>> Hello everybody,
>>
>> since i'm using the automount 5, i'm confronted with a very strange
>> behaviour. I use it to mount user directories over nfs. The automounter
>
> Are you saying that you did not experience this problem with autofs v4?
>

yes. I have downgraded to version 4 and everything works fine, but  
this is not very satisfactory.

>> maps are provided by NIS und users ususally have to login only into
>> client computers remotely using rsh or ssh. Now i encounter the following
>> missbehaviour:
>>
>> At the init, automounter seems to start propperly, but if someone logins
>> over the network into the client machine, the automounter ignores all
>> mount requests (i.e. there is no automounter activity at all). Even a
>
> This is probably because there is no lookup performed (meaning it never
> gets to autofs).  What errors are displayed in the ssh session when a
> user logs in?  Is there anything in /var/log/secure or /var/log/messages
> that may indicate a problem elsewhere?

of course there are lookups. But if an ssh or rsh login occurs, the message
is 'no such file or directory'. There is no message from automount in syslog
(only from ssh, that confirms a login). It happens exactly as i wrote, a
login through tty lets automount read the indirect maps and from this point
automunt also reacts to lookups on remote logins. The strange thing is, that
reading the indirect map happens without any lookup, just a login on tty
(e.g. root login). I'm just curious which event cause the secoud part of the
output i posted earlier.

Max
