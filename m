From: "Colin Simpson" <Colin.Simpson@iongeo.com>
Subject: Thoughts on dynamic networking with AutoFS/NFS
Date: Thu, 16 Jun 2011 20:20:21 +0100
Message-ID: <6E56BACC0FDACB4E88FD63C76CE749460D39CA@edi1exch01.iouk.ioroot.tld>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi

I was just wondering what the thoughts (maybe plans) are for making autofs/nfs more dynamic in the new world of dynamic networking with the likes of Network Manager now being the default.

We now have quite a few users with linux laptops and they want to see the standard automounts on these. But being laptops they frequently switch subnet, jump on WiFi and VPN etc. 

Most subsystems seem to play pretty well with this dynamic network environment and are hooked into NM (with SSSD doing a good job with off net credentials and directory services caching)

Now I know that autofs/nfs is a much harder nut to crack given its heavy in kernel component, but I'd have thought the present non-dynamic behaviour is a bit of an anomaly. 

Our present workaround is to hook a script into NM that detects when on or off lan. If going on lan to off, it will stop the autofs. If still mounts present when stopped, it will forcibly umount them. Pretty ugly, but better for the system than lots of dead mounts, which breaks lots of things (and doesn't recover if connecting to a new lan IP). Going off to on lan and starting autofs seems to recover and  see the automounts fine (despite the previous brutality to the mount points we performed).

We of course override the automounted home dir for the laptop owner. But they can still get to their network one via the automount when on lan. And other users can ssh into the back of these laptops (should that be necessary) and get their automounted homedir as any other machine would.

Any thoughts on this (maybe the talk of integrating automounts into sssd will change things)? Or can autofs (by option maybe) be forced to clear its mounts forcibly on being stopped.

I guess what I'm talking about isn't a common case but providing a consistent to office based systems for laptop users is very attractive for us. 

Any thoughts?

Thanks 


Colin

This email and any files transmitted with it are confidential and are intended solely for the use of the individual or entity to whom they are addressed.  If you are not the original recipient or the person responsible for delivering the email to the intended recipient, be advised that you have received this email in error, and that any use, dissemination, forwarding, printing, or copying of this email is strictly prohibited. If you received this email in error, please immediately notify the sender and delete the original.
