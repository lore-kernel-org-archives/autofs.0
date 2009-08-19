From: Lukas Haase <lukashaase@gmx.at>
Subject: Using autofs with on non-mounted directory
Date: Wed, 19 Aug 2009 16:18:35 +0200
Message-ID: <h6h1jt$bbh$1@ger.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Hi,

I have the problem that I have an indirect mount in 
"/var/lib/vz/root/500/media/media". Unfortunately this directory does 
not always exists (particulary not on system startup).

The directory exists as soon as another filesystem 
"/var/lib/vz/root/500" is mounted. I have the possibility to execute a 
script when that filesystem is mounted and umounted.

Do I have the possibility to add/remove this indirect mount somehow "on 
the fly"?

So I would start autofs without that particular indirect mount and add 
it only as soon as /var/lib/vz/root/500 is mounted. Before it is 
unmounted, the indirect mount could be removed as well.

Regards,
Luke
