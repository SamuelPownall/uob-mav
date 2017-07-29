classdef msg_airspeed_autocal < mavlink_message
	%MSG_AIRSPEED_AUTOCAL: MAVLINK Message ID = 174
    %Description:
    %    Airspeed auto-calibration
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    vx(single): GPS velocity north m/s
    %    vy(single): GPS velocity east m/s
    %    vz(single): GPS velocity down m/s
    %    diff_pressure(single): Differential pressure pascals
    %    EAS2TAS(single): Estimated to true airspeed ratio
    %    ratio(single): Airspeed ratio
    %    state_x(single): EKF state x
    %    state_y(single): EKF state y
    %    state_z(single): EKF state z
    %    Pax(single): EKF Pax
    %    Pby(single): EKF Pby
    %    Pcz(single): EKF Pcz
	
	properties(Constant)
		ID = 174
		LEN = 48
	end
	
	properties
        vx	%GPS velocity north m/s	|	(single)
        vy	%GPS velocity east m/s	|	(single)
        vz	%GPS velocity down m/s	|	(single)
        diff_pressure	%Differential pressure pascals	|	(single)
        EAS2TAS	%Estimated to true airspeed ratio	|	(single)
        ratio	%Airspeed ratio	|	(single)
        state_x	%EKF state x	|	(single)
        state_y	%EKF state y	|	(single)
        state_z	%EKF state z	|	(single)
        Pax	%EKF Pax	|	(single)
        Pby	%EKF Pby	|	(single)
        Pcz	%EKF Pcz	|	(single)
    end

    methods

        function obj = msg_airspeed_autocal(packet,vx,vy,vz,diff_pressure,EAS2TAS,ratio,state_x,state_y,state_z,Pax,Pby,Pcz)
        %Create a new airspeed_autocal message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
            
            elseif nargin-1 == 12
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.diff_pressure = diff_pressure;
                obj.EAS2TAS = EAS2TAS;
                obj.ratio = ratio;
                obj.state_x = state_x;
                obj.state_y = state_y;
                obj.state_z = state_z;
                obj.Pax = Pax;
                obj.Pby = Pby;
                obj.Pcz = Pcz;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_airspeed_autocal.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_airspeed_autocal.ID;
                
                packet.payload.putSINGLE(obj.vx);
                packet.payload.putSINGLE(obj.vy);
                packet.payload.putSINGLE(obj.vz);
                packet.payload.putSINGLE(obj.diff_pressure);
                packet.payload.putSINGLE(obj.EAS2TAS);
                packet.payload.putSINGLE(obj.ratio);
                packet.payload.putSINGLE(obj.state_x);
                packet.payload.putSINGLE(obj.state_y);
                packet.payload.putSINGLE(obj.state_z);
                packet.payload.putSINGLE(obj.Pax);
                packet.payload.putSINGLE(obj.Pby);
                packet.payload.putSINGLE(obj.Pcz);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.vx = payload.getSINGLE();
            obj.vy = payload.getSINGLE();
            obj.vz = payload.getSINGLE();
            obj.diff_pressure = payload.getSINGLE();
            obj.EAS2TAS = payload.getSINGLE();
            obj.ratio = payload.getSINGLE();
            obj.state_x = payload.getSINGLE();
            obj.state_y = payload.getSINGLE();
            obj.state_z = payload.getSINGLE();
            obj.Pax = payload.getSINGLE();
            obj.Pby = payload.getSINGLE();
            obj.Pcz = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';
            elseif size(obj.diff_pressure,2) ~= 1
                result = 'diff_pressure';
            elseif size(obj.EAS2TAS,2) ~= 1
                result = 'EAS2TAS';
            elseif size(obj.ratio,2) ~= 1
                result = 'ratio';
            elseif size(obj.state_x,2) ~= 1
                result = 'state_x';
            elseif size(obj.state_y,2) ~= 1
                result = 'state_y';
            elseif size(obj.state_z,2) ~= 1
                result = 'state_z';
            elseif size(obj.Pax,2) ~= 1
                result = 'Pax';
            elseif size(obj.Pby,2) ~= 1
                result = 'Pby';
            elseif size(obj.Pcz,2) ~= 1
                result = 'Pcz';

            else
                result = 0;
            end
        end

        function set.vx(obj,value)
            obj.vx = single(value);
        end
        
        function set.vy(obj,value)
            obj.vy = single(value);
        end
        
        function set.vz(obj,value)
            obj.vz = single(value);
        end
        
        function set.diff_pressure(obj,value)
            obj.diff_pressure = single(value);
        end
        
        function set.EAS2TAS(obj,value)
            obj.EAS2TAS = single(value);
        end
        
        function set.ratio(obj,value)
            obj.ratio = single(value);
        end
        
        function set.state_x(obj,value)
            obj.state_x = single(value);
        end
        
        function set.state_y(obj,value)
            obj.state_y = single(value);
        end
        
        function set.state_z(obj,value)
            obj.state_z = single(value);
        end
        
        function set.Pax(obj,value)
            obj.Pax = single(value);
        end
        
        function set.Pby(obj,value)
            obj.Pby = single(value);
        end
        
        function set.Pcz(obj,value)
            obj.Pcz = single(value);
        end
        
    end

end