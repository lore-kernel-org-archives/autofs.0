From: Ahmon Dancy <dancy@franz.com>
Subject: Re: Two problems w/ autofs
Date: Wed, 18 Feb 2009 08:06:55 -0800
Message-ID: <4091.1234973215@dancy>
References: <5144.1234914721@dancy> <1234924209.3090.9.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <1234924209.3090.9.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

>> On Tue, 2009-02-17 at 15:52 -0800, Ahmon Dancy wrote:
>> > Hello Ian, et al.
>> > 
>> > Using autofs-5.0.3-36 (built from Fedora 10 updates source RPM) on
>> > 2.6.26.6-49.fc8 kernel.  We run w/ LOGGING=debug.
>> 
>> You will need update your 2.6.26 based kernel with the latest kernel
>> module patch before we go further with this. It can be found in the
>> patches directory of the 5.0.4 tarball on kernel.org.

Is there any released fedora-supplied kernel (perhaps for Fedora 9
or 10) that has the necessary goods?  If the system in question needs
to be restarted for a kernel update, it may be a good time to update
the Fedora installation as well.
