From: Lukas Haase <lukashaase@gmx.at>
Subject: Re: Using autofs with on non-mounted directory
Date: Fri, 28 Aug 2009 18:01:19 +0200
Message-ID: <h78v0g$rhg$1@ger.gmane.org>
References: <h6h1jt$bbh$1@ger.gmane.org>
	<x49tyzs3sed.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49tyzs3sed.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Jeff Moyer schrieb:
> Lukas Haase <lukashaase@gmx.at> writes:
>> Hi,

Hi,

>> I have the problem that I have an indirect mount in
>> "/var/lib/vz/root/500/media/media". Unfortunately this directory does
>> not always exists (particulary not on system startup).
> 
> So it doesn't get mounted automatically?  If it *is* mounted as part of
> startup, then it sounds like you just need to move that sooner in your
> boot order.

No, that would be easy, of course. The actual problem is, that I want to 
have the indirect mount into an OpenVZ container. OpenVZ "bind mounts" 
its data root into the directory above before starting a container: 
/var/lib/vz/private/500/media/media --> /var/lib/vz/root/500/media/media.

And of course, the container is not always started. But I can call a 
script when starting/stopping a container.

>> The directory exists as soon as another filesystem
>> "/var/lib/vz/root/500" is mounted. I have the possibility to execute a
>> script when that filesystem is mounted and umounted.
> 
>> Do I have the possibility to add/remove this indirect mount somehow
>> "on the fly"?
> 
> You would have to script this yourself.  There is no real api to tell
> the automounter to add map entries.

Yes, but how?

Would it be possible to change the config files and send e.g. a HUP ?

That way, I could dynamically add the apropriate line on container 
startup and issue HUP, and remove the line when the container shuts down.

Regards,
Luke
